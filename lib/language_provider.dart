import 'package:flutter/material.dart';

// This holds the current language. Default is English.
ValueNotifier<Locale> appLocale = ValueNotifier(const Locale('en'));

void updateLanguage(String code) {
  appLocale.value = Locale(code);
}