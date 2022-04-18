import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:projectb/configs/buttons.dart';
import 'package:projectb/configs/configs.dart';
import 'package:projectb/configs/texts.dart';
import 'package:projectb/functions/validate_email.dart';
import 'package:projectb/views/signup_view.dart';
import 'package:provider/provider.dart';
import '../configs/colors.dart';
import '../functions/remove_spaces.dart';
import '../services/auth_service.dart';
import '../widgets/snackbar_message.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  var _passwordVisible = false;

  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;

  login() async {
    try {
      await context.read<AuthService>().login(
          removeSpaces(emailController.text),
          removeSpaces(passController.text));
    } on AuthException catch (e) {
      snackbarMessage(e.message, _scaffoldKey, context);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  void callback() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Image(
                    image: AssetImage('assets/mobile_login.png'),
                    height: 300,
                  ),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: secondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "Login to your account",
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: primaryTextStyle,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    style: formStyle,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    decoration: formStyleFunction("Email"),
                                    validator: (String? value) => validateEmail(
                                      removeSpaces(value!),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    style: formStyle,
                                    keyboardType: TextInputType.text,
                                    controller: passController,
                                    decoration: formPasswordStyleFunction(
                                        "Password", _passwordVisible, context, callback),
                                    obscureText: !_passwordVisible,
                                    validator: (String? value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          removeSpaces(value).length < 8) {
                                        return 'The password is too week';
                                      }
                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 16.0),
                                    child: ElevatedButton(
                                      style: primaryButtonStyle,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          login();
                                        }
                                      },
                                      child: Text(
                                        'Login on your account',
                                        style: primaryTextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text("Forgot Password?",
                                  textDirection: TextDirection.ltr),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: primaryButtonStyle,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => const SignUpView()));
                    },
                    child: Text("Create Account",
                        style: primaryTextStyle, textDirection: TextDirection.ltr),
                  ),
                ],
              ),
            ),
          ),

    );
  }
}
