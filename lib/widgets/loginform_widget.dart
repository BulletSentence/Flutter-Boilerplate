import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:projectb/config/app_theme.dart';
import 'package:projectb/config/configs.dart';
import 'package:projectb/functions/remove_spaces.dart';
import 'package:projectb/functions/validate_email.dart';
import 'package:projectb/widgets/loading_widget.dart';

import '../shared/string_texts.dart';

//Login Form Widget
String headerLogin = "auth-header-login".i18n();
String emailHint = "auth-hint-email".i18n();
String passHint = "auth-hint-password".i18n();
String btnLoginText = "auth-btn-login".i18n();
String recoverPass = "auth-forgot-pass".i18n();

Widget loginFormWidget(
    BuildContext context,
    var _formKey,
    var emailController,
    var passController,
    var _passwordVisible,
    bool loading,
    Function() callback,
    Function() login,
    Function() googleLogin) {
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
              headerLogin,
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
                  decoration: formStyleFunction(emailHint),
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
                      passHint, _passwordVisible, context, callback),
                  obscureText: !_passwordVisible,
                  validator: (String? value) {
                    if (value == null ||
                        value.isEmpty ||
                        removeSpaces(value).length < 8) {
                      return weakPassText;
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: (loading)
                      ? loadingWidget(context)
                      : ElevatedButton(
                          style: primaryButtonStyle,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login();
                            }
                          },
                          child: Text(
                            btnLoginText,
                            style: primaryTextStyle,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: (loading)
                      ? ElevatedButton(
                          style: whiteButtonStyle,
                          onPressed: () {
                            Navigator.popAndPushNamed(context,'/auth');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage("assets/images/ico-google.png"),
                                height: 20,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                googleBtnText,
                                style: darkPrimaryTextStyle,
                              ),
                            ],
                          ))
                      : ElevatedButton(
                          style: whiteButtonStyle,
                          onPressed: () {
                            googleLogin();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Image(
                                image: AssetImage("assets/images/ico-google.png"),
                                height: 20,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                googleBtnText,
                                style: darkPrimaryTextStyle,
                              ),
                            ],
                          )),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(recoverPass, textDirection: TextDirection.ltr),
          ),
        ],
      ),
    ),
  );
}
