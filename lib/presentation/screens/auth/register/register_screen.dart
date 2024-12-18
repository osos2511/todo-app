import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/assets_manager.dart';
import 'package:todo_app/core/constant_manager.dart';
import 'package:todo_app/core/routes_manager.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';
import '../../../../core/reusable_components/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF004182),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Container(
                height: 80,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Center(child: Image.asset(AssetsManager.routeLogo)),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTitleField(AppLocalizations.of(context)!.full_name),
                      buildFullNameField(),
                      buildTitleField(AppLocalizations.of(context)!.user_name),
                      buildUserNameField(),
                      buildTitleField(AppLocalizations.of(context)!.email),
                      buildEmailField(),
                      buildTitleField(AppLocalizations.of(context)!.password),
                      buildPassField(),
                      buildTitleField(AppLocalizations.of(context)!.re_password),
                      buildRePassField(),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          signUp();
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Text(
                          AppLocalizations.of(context)!.sign_up,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                             AppLocalizations.of(context)!.already_have_account,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, RoutesManager.loginRoute);
                              },
                              child:  Text(
                                AppLocalizations.of(context)!.sign_in,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFullNameField() => CustomTextFormField(
        hintText: AppLocalizations.of(context)!.enter_your_full_name,
        validator: (input) {
          String pattern = r'^[a-zA-Z]+$';
          RegExp regex = RegExp(pattern);
          if (input == null || input.trim().isEmpty) {
            return 'plz,enter your full name';
          }
          if (input.length < 6) {
            return 'your full name should be at least 6 chars';
          }
          if (!regex.hasMatch(input)) {
            return 'Invalid format. Only letters allowed';
          }
          return null;
        },
        controller: fullNameController,
      );
  Widget buildUserNameField() => CustomTextFormField(
        hintText: AppLocalizations.of(context)!.enter_your_user_name,
        validator: (input) {
          if (input == null || input.trim().isEmpty) {
            return 'plz,enter your user name';
          }
          return null;
        },
        controller: userNameController,
      );
  Widget buildEmailField() => CustomTextFormField(
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
  Widget buildPassField() => CustomTextFormField(
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
  Widget buildRePassField() => CustomTextFormField(
        hintText: AppLocalizations.of(context)!.enter_your_re_password,
        validator: (input) {
          if (input == null || input.trim().isEmpty) {
            return 'plz,enter your password';
          }
          if (input.length < 8) {
            return 'your re-password should be at least 8 chars';
          }
          return null;
        },
        controller: rePasswordController,
        isSecure: true,
      );
  buildTitleField(String titleField) => Text(
        titleField,
        style: Theme.of(context).textTheme.labelMedium,
      );

  void signUp() async {
    try {
      DialogUtils.showLoadingDialog(context, message: 'Loading...');
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      UserDm user=UserDm(id: credential.user!.uid, userName: userNameController.text, fullName: fullNameController.text, email: emailController.text);
      addUserToFireStore(user);
      DialogUtils.hideDialog(context);
      DialogUtils.messagingDialog(context,
          content: 'User Registered Successfully',
          posActionTitle: 'Ok', posAction: () {
        Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
      });
    } on FirebaseAuthException catch (authError) {
      DialogUtils.hideDialog(context);
      String message;
      if (authError.code == AppConstants.weakPassword) {
        message = AppConstants.weakPasswordMessage;
      } else if (authError.code == AppConstants.emailAlreadyInUse) {
        message = AppConstants.emailAlreadyInUseMessage;
      } else {
        message = AppConstants.somethingWentWrongMessage;
      }
      DialogUtils.messagingDialog(context,
          title: 'Error', content: message, posActionTitle: 'ok');
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.messagingDialog(context,
          title: 'Error', content: e.toString(), posActionTitle: 'ok');
    }
  }

  void addUserToFireStore(UserDm user) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(UserDm.collectionName);
    DocumentReference documentReference = collectionReference.doc(user.id);
    await documentReference.set(user.toFireStore());
  }
}
