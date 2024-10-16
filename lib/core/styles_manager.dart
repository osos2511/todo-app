import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';

class MyTextStyles {
  static TextStyle appBarTextStyle = const TextStyle(
    color: ColorsManager.whiteColor,
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );
  static TextStyle cardTitleTextStyle = const TextStyle(
      fontWeight: FontWeight.w600, color: Color(0xFF5D9CEC), fontSize: 20);
  static TextStyle cardTimeTextStyle = const TextStyle(
      fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15);
  static TextStyle settingsItemTextStyle = const TextStyle(
      fontWeight: FontWeight.w700, color: Colors.black, fontSize: 20);
}

