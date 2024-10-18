import 'package:flutter/material.dart';
import 'package:todo_app/core/assets_manager.dart';
import 'package:todo_app/core/strings_manager.dart';
import '../../../../core/reusable_components/custom_text_form_field.dart';
import '../../../../core/routes_manager.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'E-mail',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  buildEmailField(),
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  buildPassField(),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: Text(
                      StringsManager.logIn,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Dont have account?',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, RoutesManager.registerRoute);
                          },
                          child: const Text(
                            StringsManager.register,
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
    );
  }

  Widget buildEmailField()=>CustomTextFormField(
    hintText: 'Enter your E-mail',
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
    hintText: 'Enter your password',
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
}
