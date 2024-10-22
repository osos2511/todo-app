import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';

class MyTheme {
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsManager.blueColor,
      primary: ColorsManager.blueColor,
    ),
    primaryColor: ColorsManager.blueColor,
    dividerColor: ColorsManager.blueColor,
    indicatorColor: Colors.white,
    canvasColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorsManager.blueColor,
      elevation: 4,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: ColorsManager.whiteColor,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
    scaffoldBackgroundColor: ColorsManager.lightScaffoldBg,
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

    textTheme: const TextTheme(
      titleMedium:TextStyle(
          fontWeight: FontWeight.w600, color: Color(0xFF5D9CEC), fontSize: 20),
      titleSmall: TextStyle(
          fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
      labelSmall: TextStyle(
          fontWeight: FontWeight.w700, color: Colors.black, fontSize: 20),
      labelMedium: TextStyle(
          fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
      displaySmall: TextStyle(color: Color(0xFF004182),fontSize: 18,fontWeight: FontWeight.w800),
      headlineMedium: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Color(0xFF383838)),
      displayMedium: TextStyle(
          color: Color(0xFFA9A9A99C),
          fontWeight: FontWeight.w400,
          fontSize: 15),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight:Radius.circular(12) ,
          topLeft: Radius.circular(12)
        )
      )
    ),
    iconTheme: IconThemeData(
        color: ColorsManager.black
    ),
    // datePickerTheme: DatePickerThemeData(
    //   backgroundColor: ColorsManager.blueColor
    // ),
  );


  static ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsManager.blackAccent,
      primary: ColorsManager.blackAccent,
    ),
    primaryColor: ColorsManager.blueColor,
    dividerColor: ColorsManager.blueColor,
    indicatorColor: ColorsManager.blackAccent,
    canvasColor: Colors.white,

    appBarTheme: const AppBarTheme(
      backgroundColor: ColorsManager.blueColor,
      elevation: 4,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: ColorsManager.black,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
    scaffoldBackgroundColor: ColorsManager.black,
    useMaterial3: false,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: ColorsManager.blueColor,
      unselectedItemColor: ColorsManager.greyColor,
      elevation: 0,
      selectedIconTheme: IconThemeData(size: 32),
    ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: ColorsManager.blackAccent,
        elevation: 14,
        shape: CircularNotchedRectangle(),
      ),


    floatingActionButtonTheme:  const FloatingActionButtonThemeData(
        shape: StadiumBorder(
          side: BorderSide(color: ColorsManager.blackAccent, width: 4),
        ),
        backgroundColor: ColorsManager.blueColor,
        elevation: 12,
        iconSize: 26),

    cardTheme: const CardTheme(
      color: ColorsManager.blackAccent,
      elevation: 20,
    ),

    textTheme: const TextTheme(
      titleMedium:TextStyle(
          fontWeight: FontWeight.w600, color: Color(0xFF5D9CEC), fontSize: 20),
      titleSmall: TextStyle(
          fontWeight: FontWeight.w400, color: ColorsManager.whiteColor, fontSize: 15),
      labelSmall: TextStyle(
          fontWeight: FontWeight.w700, color: Colors.white, fontSize: 20),
      labelMedium: TextStyle(
          fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),
      displaySmall: TextStyle(color: Color(0xFF004182),fontSize: 18,fontWeight: FontWeight.w800),
      headlineMedium: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),
      displayMedium: TextStyle(
          color: Color(0xFFA9A9A99C),
          fontWeight: FontWeight.w400,
          fontSize: 15),
    ),
    iconTheme: IconThemeData(
      color: ColorsManager.whiteColor
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorsManager.blackAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight:Radius.circular(12) ,
          topLeft: Radius.circular(12)
        ),
      ),
    ),
    // datePickerTheme: DatePickerThemeData(
    //     backgroundColor: ColorsManager.blackAccent
    // ),


  );
}
