import 'package:flutter/material.dart';
import 'package:projectb/configs/buttons.dart';
import 'package:projectb/configs/colors.dart';
import 'package:projectb/configs/configs.dart';
import 'package:projectb/configs/texts.dart';
import 'package:projectb/functions/remove_spaces.dart';
import 'package:projectb/functions/validate_email.dart';
import 'package:projectb/widgets/loading_widget.dart';

  Widget loginFormWidget(
      BuildContext context,
      var _formKey,
      var emailController,
      var passController,
      var _passwordVisible,
      bool loading,
      Function() callback,
      Function() login
      ) {
    return Card(
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
                    child: (loading) ? loadingWidget(context) : ElevatedButton(
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
    );
  }
