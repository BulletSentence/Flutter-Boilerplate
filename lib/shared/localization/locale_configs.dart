import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

Iterable<Locale> supLang = [
  const Locale('en', 'US'),
  const Locale('pt', 'BR'),
];

Iterable<LocalizationsDelegate<dynamic>>? locDel = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  LocalJsonLocalization.delegate,
];


