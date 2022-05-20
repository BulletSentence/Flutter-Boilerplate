import 'package:flutter/material.dart';

const primaryColor = Color(0xff2C3333);
const secondaryColor = Color(0xff395B64);
const accentColor = Color(0xff2666CF);
const textColor = Color(0xffF5F2E7);
const whiteColor = Colors.white;
const warningColor = Colors.yellow;
const errorColor = Colors.redAccent;
const bgColor = Color(0xff395B64);
final kShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
final kActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);

TextStyle primaryTextStyle = const TextStyle (
    color: textColor, fontSize: 16, fontWeight: FontWeight.w600);

TextStyle primaryTextStyleBold = const TextStyle (
    color: textColor, fontSize: 18, fontWeight: FontWeight.bold);

TextStyle primaryBigTextStyleBold = const TextStyle (
    color: textColor, fontSize: 20, fontWeight: FontWeight.bold);

TextStyle subtitleTextStyle = const TextStyle (
    color: textColor, fontSize: 15, fontWeight: FontWeight.normal);

TextStyle darkPrimaryTextStyle = const TextStyle (
    color: primaryColor, fontSize: 16, fontWeight: FontWeight.w600);

TextStyle formStyle = const TextStyle(
  color: whiteColor,
);

final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
  onSurface: primaryColor,
  onPrimary: whiteColor,
  primary: accentColor,
  minimumSize: const Size.fromHeight(50),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

final ButtonStyle whiteButtonStyle = ElevatedButton.styleFrom(
  onSurface: whiteColor,
  onPrimary: primaryColor,
  primary: whiteColor,
  minimumSize: const Size.fromHeight(50),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

// Text Style
const kHeadingTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

const kTitleTextstyle = TextStyle(
  fontSize: 18,
  color: primaryColor,
  fontWeight: FontWeight.bold,
);