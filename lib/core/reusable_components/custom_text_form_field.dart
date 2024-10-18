import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({super.key,required this.hintText,required this.validator,required this.controller,this.isSecure=false});
String hintText;
String? Function(String?)? validator;
TextEditingController?controller;
bool isSecure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isSecure,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 2,color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 2,color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 2,color: Colors.white),
        ),
        errorBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(width: 2,color: Colors.red),),
        hintText:hintText,
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
            color: Color(0xFF000000),
        ),
      ),
    );
  }
}
