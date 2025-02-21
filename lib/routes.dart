import 'package:flutter/material.dart';
import 'package:vecinapp/screens/home.dart';
import 'package:vecinapp/screens/login.dart';
import 'package:vecinapp/screens/welcome.dart';


RouteFactory routes() {
  return (settings) {
    final Map<String, dynamic> arguments = settings.arguments;
    Widget screen;
    switch (settings.name) {
      case '/':
        screen = WelcomeScreen();
        break;
      case '/home':
        screen = HomeScreen();
        break;
      case '/userLogin':
        screen = LoginScreen(arguments['email']);
        break;
      default:
        return null;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}