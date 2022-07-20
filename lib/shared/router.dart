import 'package:flutter/material.dart';
import 'package:userauth/modules/auth/routes/route.dart';
import 'package:userauth/modules/auth/screens/signup_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // Auth
    case AuthRoutes.signup:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());

    default:
      {
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      }
  }
}
