import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/my_theme.dart';
import 'package:todo_app/core/routes_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesManager.router,
      initialRoute: RoutesManager.registerRoute,
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme,
    );
  }
}