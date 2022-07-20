import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:userauth/firebase_options.dart';
import 'package:userauth/modules/auth/routes/route.dart';
import 'package:userauth/shared/router.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const UserAuthApp());
}

class UserAuthApp extends StatelessWidget {
  const UserAuthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AuthRoutes.login,
      onGenerateRoute: router.generateRoute,
    );
  }
}
