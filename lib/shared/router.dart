import 'package:flutter/material.dart';
import 'package:userauth/modules/auth/routes/route.dart';
import 'package:userauth/modules/auth/screens/login_screen.dart';
import 'package:userauth/modules/auth/screens/signup_screen.dart';
import 'package:userauth/modules/home/routes/route.dart';
import 'package:userauth/modules/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // Auth
    case AuthRoutes.signup:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case AuthRoutes.login:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case HomeRoutes.home:
      HomeScreen? arg = settings.arguments as HomeScreen?;
      return MaterialPageRoute(
          builder: (context) => HomeScreen(
                user: arg!.user,
              ));
    default:
      {
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      }
  }
}
