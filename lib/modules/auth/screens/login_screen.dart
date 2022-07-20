import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:userauth/helpers/alert_helper.dart';
import 'package:userauth/modules/auth/models/login_model.dart';
import 'package:userauth/modules/auth/routes/route.dart';
import 'package:userauth/modules/auth/services/auth_service.dart';
import 'package:userauth/modules/home/routes/route.dart';
import 'package:userauth/modules/home/screens/home_screen.dart';
import 'package:validators/validators.dart' as validator;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool _isLoading = false;
  late final LoginModel _loginModel = LoginModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailTextController,
                validator: (value) {
                  if (!validator.isEmail(value!.trim())) {
                    return 'enter a valid mail';
                  }
                  return null;
                },
                onSaved: (value) {
                  _loginModel.email = _emailTextController.text.trim();
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: obscureText,
                controller: _passwordTextController,
                onSaved: (value) {
                  _loginModel.password = _passwordTextController.text.trim();
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  suffix: GestureDetector(
                    onTap: () => setState(() {
                      obscureText = !obscureText;
                    }),
                    child: Icon(
                      obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                onChanged: (value) {},
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'enter password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                child: Text(_isLoading ? 'Please Wait...' : 'Login'),
                onPressed: () async {
                  if (_loginFormKey.currentState!.validate()) {
                    _loginFormKey.currentState!.save();
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      User? user =
                          await AuthService.login(loginModel: _loginModel);
                      if (user != null) {
                        Navigator.popAndPushNamed(context, HomeRoutes.home,
                            arguments: HomeScreen(user: user));
                      }
                    } catch (e) {
                      showAlert(
                        context: context,
                        title: 'Oops!',
                        content: e.toString(),
                      );
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AuthRoutes.signup);
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
