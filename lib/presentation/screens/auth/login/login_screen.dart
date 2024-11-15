import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/assets_manager.dart';
import 'package:todo_app/core/strings_manager.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';
import '../../../../core/constant_manager.dart';
import '../../../../core/reusable_components/custom_text_form_field.dart';
import '../../../../core/routes_manager.dart';
import '../../../../core/utils/dialog_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF004182),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 80,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: Image.asset(AssetsManager.routeLogo)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.email,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    buildEmailField(),
                    Text(
                      AppLocalizations.of(context)!.password,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    buildPassField(),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signIn(context);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text(
                        AppLocalizations.of(context)!.sign_in,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          AppLocalizations.of(context)!.dont_have_account,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, RoutesManager.registerRoute);
                            },
                            child:  Text(
                              AppLocalizations.of(context)!.sign_up,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline),
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailField()=>CustomTextFormField(
    hintText: AppLocalizations.of(context)!.enter_your_email,
    validator: (input) {
      if (input == null || input.trim().isEmpty) {
        return 'plz,enter your E-mail';
      }
      return null;
      //check email format
    },
    controller: emailController,
  );

  Widget buildPassField()=>CustomTextFormField(
    hintText: AppLocalizations.of(context)!.enter_your_password,
    validator: (input) {
      if (input == null || input.trim().isEmpty) {
        return 'plz,enter your password';
      }
      if (input.length < 8) {
        return 'your password should be at least 8 chars';
      }
      return null;
    },
    controller: passwordController,
    isSecure: true,
  );

    void signIn(context) async{

      try {
        DialogUtils.showLoadingDialog(context,message: 'Loading...');
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        UserDm.userDm=await getUserFromFireStore(credential.user!.uid);
        DialogUtils.hideDialog(context);
        DialogUtils.messagingDialog(context,content: 'User Logged-In Now',posActionTitle: 'Ok',posAction: (){
          Navigator.pushReplacementNamed(context, RoutesManager.homeRoute);
        });
      } on FirebaseAuthException catch (authError) {
        DialogUtils.hideDialog(context);
        String message;
        if (authError.code == AppConstants.invalidCredential) {
          message=AppConstants.wrongEmailOrPassword;
          DialogUtils.messagingDialog(context,title: 'Error',content: message,posActionTitle: 'ok');
        }
      } catch (e) {
        DialogUtils.hideDialog(context);
        DialogUtils.messagingDialog(context,title: 'Error',content: e.toString(),posActionTitle: 'ok');
      }
  }

  getUserFromFireStore(String uid)async{
    CollectionReference collectionReference=
    FirebaseFirestore.instance.collection(UserDm.collectionName);
    DocumentReference userDoc=collectionReference.doc(uid);
    DocumentSnapshot documentSnapshot= await userDoc.get();
    var json=documentSnapshot.data() as Map<String,dynamic>;
    return UserDm.fromFireStore(json);
  }
}
