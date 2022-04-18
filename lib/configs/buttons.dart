import 'package:flutter/material.dart';
import 'package:projectb/configs/colors.dart';

final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
  onSurface: primaryColor,
  onPrimary: whiteColor,
  primary: accentColor,
  minimumSize: const Size.fromHeight(50),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);