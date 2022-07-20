import 'package:flutter/material.dart';
import 'package:userauth/helpers/alert_helper.dart';
import 'package:userauth/modules/auth/models/signup_model.dart';
import 'package:userauth/modules/auth/services/auth_service.dart';
import 'package:validators/validators.dart' as validator;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _signupFormKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool _isLoading = false;
  late final SignUpModel _signUpModel = SignUpModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _signupFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameTextController,
                validator: (value) {
                  if (!validator.isAlpha(value!.trim())) {
                    return 'enter a valid name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _signUpModel.name = _nameTextController.text.trim();
                },
                decoration: InputDecoration(
                  labelText: 'Name',
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
                controller: _emailTextController,
                validator: (value) {
                  if (!validator.isEmail(value!.trim())) {
                    return 'enter a valid mail';
                  }
                  return null;
                },
                onSaved: (value) {
                  _signUpModel.email = _emailTextController.text.trim();
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
                  _signUpModel.password = _passwordTextController.text.trim();
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
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'enter password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                child: Text(_isLoading ? 'Please Wait...' : 'Sign Up'),
                onPressed: () async {
                  if (_signupFormKey.currentState!.validate()) {
                    _signupFormKey.currentState!.save();
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      await AuthService.signUp(signupModel: _signUpModel);
                      Navigator.pop(context);
                      showAlert(
                        context: context,
                        title: 'Success',
                        content:
                            'Kindly check your email to verify your account.',
                      );
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
                  const Text("Already have an account?"),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
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
