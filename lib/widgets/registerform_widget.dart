import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:projectb/config/app_theme.dart';
import 'package:projectb/config/configs.dart';
import 'package:projectb/functions/remove_spaces.dart';
import 'package:projectb/functions/validate_email.dart';
import 'package:projectb/shared/string_texts.dart';
import 'package:projectb/widgets/loading_widget.dart';

//Texts
String headerCreate = "auth-header-create".i18n();
String emailHint = "auth-hint-email".i18n();
String passHint = "auth-hint-password".i18n();
String btnCreateText = "auth-btn-sign-in".i18n();
String fullNameHint = "auth-full-name".i18n();

Widget registerFormWidget(
    BuildContext context,
    var _formKey,
    var nameController,
    var emailController,
    var passController,
    var _passwordVisible,
    bool loading,
    Function() callback,
    Function() register,
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
              headerCreate,
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
                  decoration: formStyleFunction(fullNameHint),
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
                  decoration: formStyleFunction(emailHint),
                  validator: (String? value) =>
                      validateEmail(removeSpaces(value!)),
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
                      return 'The password needs to be more secured';
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
                              register();
                            }
                          },
                          child: Text(
                            btnCreateText,
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
                            googleCreateText,
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
                            googleCreateText,
                            style: darkPrimaryTextStyle,
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
