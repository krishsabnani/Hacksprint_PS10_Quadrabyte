import 'package:flutter/material.dart';
import 'package:hacksprintps10quadrabyte/Pages/login_screen.dart';
import 'package:hacksprintps10quadrabyte/Pages/menu.dart';
import 'package:hacksprintps10quadrabyte/Pages/register_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String menu = '/menu';
  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => Login(),
      authRegister: (context) => Register(),
      menu: (context) => MenuScreen(),
    };
  }
}
