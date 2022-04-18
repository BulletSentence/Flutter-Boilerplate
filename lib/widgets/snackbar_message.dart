import 'package:flutter/material.dart';
import 'package:projectb/configs/texts.dart';

snackbarMessage(String msg, Key scaffoldKey, var context) async {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      key: scaffoldKey,
      backgroundColor: Colors.red,
      content: Text(
        msg,
        style: primaryTextStyle,
      ),
    ),
  );
}
