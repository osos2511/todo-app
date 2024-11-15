import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/theme/my_theme.dart';
import 'package:todo_app/core/routes_manager.dart';
import '../provider/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesManager.router,
      initialRoute: RoutesManager.loginRoute,
      themeMode: provider.currentTheme,
      theme: MyTheme.light,
      darkTheme: MyTheme.dark,
    );
  }
}