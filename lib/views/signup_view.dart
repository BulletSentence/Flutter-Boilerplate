import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projectb/configs/buttons.dart';
import 'package:projectb/configs/colors.dart';
import 'package:projectb/configs/configs.dart';
import 'package:projectb/configs/texts.dart';
import 'package:projectb/functions/validate_email.dart';
import 'package:projectb/services/auth_service.dart';
import 'package:projectb/widgets/auth_widget.dart';
import 'package:projectb/widgets/snackbar_message.dart';
import 'package:provider/provider.dart';

import '../functions/remove_spaces.dart';
import 'login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  var _passwordVisible = false;

  register() async {
    try {
      await context.read<AuthService>().registrar(
          removeSpaces(emailController.text),
          removeSpaces(passController.text),
          nameController.text);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const AuthCheck()));
    } on AuthException catch (e) {
      snackbarMessage(e.message, _scaffoldKey, context);
    }
  }

  void callback() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                            "Create a new account",
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
                                keyboardType: TextInputType.name,
                                controller: nameController,
                                decoration: formStyleFunction("Full Name"),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                style: formStyle,
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                decoration: formStyleFunction("Your Email"),
                                validator: (String? value) =>
                                    validateEmail(removeSpaces(value!)),
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
                                    return 'The password needs to be more secured';
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
                                      register();
                                    }
                                  },
                                  child: Text(
                                    'Create Account!',
                                    style: primaryTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                      builder: (BuildContext context) => const LoginView()));
                },
                child: Text("Login your Account",
                    style: primaryTextStyle, textDirection: TextDirection.ltr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
