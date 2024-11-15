import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/auth/login/login_screen.dart';
import 'package:todo_app/presentation/screens/auth/register/register_screen.dart';
import 'package:todo_app/presentation/screens/home/home_screen.dart';
import 'package:todo_app/presentation/screens/home/update_task/update_task_screen.dart';

class RoutesManager{
  static const String homeRoute='/home';
  static const String registerRoute='/register';
  static const String loginRoute='/login';
  static const String updateRoute='/update';

  static Route<dynamic>? router(RouteSettings settings){
    switch(settings.name){
      case homeRoute:{
        return MaterialPageRoute(builder: (context) => const HomeScreen(),);
      }
      case registerRoute:{
        return MaterialPageRoute(builder: (context) =>  RegisterScreen(),);
      }
      case loginRoute:{
        return MaterialPageRoute(builder: (context) =>  LoginScreen(),);
      }
      case updateRoute:{
        return MaterialPageRoute(builder: (context) =>  UpdateTaskScreen(),);
      }
    }
    return null;
  }
}