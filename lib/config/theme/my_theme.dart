import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/styles_manager.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: ColorsManager.blueColor,
    dividerColor: ColorsManager.blueColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.blueColor,
      elevation: 4,
      centerTitle: true,
      titleTextStyle: MyTextStyles.appBarTextStyle,
    ),
    scaffoldBackgroundColor: ColorsManager.scaffoldColor,
    useMaterial3: false,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: ColorsManager.blueColor,
      unselectedItemColor: ColorsManager.greyColor,
      elevation: 0,
      selectedIconTheme: IconThemeData(size: 32),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: StadiumBorder(
          side: BorderSide(color: Colors.white, width: 4),
        ),
        backgroundColor: ColorsManager.blueColor,
        elevation: 12,
        iconSize: 26),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: ColorsManager.whiteColor,
      elevation: 14,
      shape: CircularNotchedRectangle(),
    ),
    cardTheme: const CardTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
    textTheme: TextTheme(
      titleMedium:MyTextStyles.cardTitleTextStyle,
      titleSmall: MyTextStyles.cardTimeTextStyle,
      labelSmall: MyTextStyles.settingsItemTextStyle,
      labelMedium: MyTextStyles.textFormFieldTextStyle,
      displaySmall: MyTextStyles.elevatedButtonTextStyle,
    ),
  );
}
