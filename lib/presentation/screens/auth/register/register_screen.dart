import 'package:flutter/material.dart';
import 'package:todo_app/core/assets_manager.dart';

import '../../../../core/reusable_components/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
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
                      Text(
                        'Full Name',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: 'Enter your full name',
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
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'User Name',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: 'Enter your user name',
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return 'plz,enter your user name';
                          }
                          return null;
                        },
                        controller: userNameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'E-mail',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: 'Enter your E-mail',
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return 'plz,enter your E-mail';
                          }
                          //check email format
                        },
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Password',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: 'Enter your password',
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return 'plz,enter your password';
                          }
                          if (input.length < 8) {
                            return 'your password should be at least 8 chars';
                          }
                        },
                        controller: passwordController,
                        isSecure: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Re-password',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: 'Confirm password',
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
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Register',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
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
}
