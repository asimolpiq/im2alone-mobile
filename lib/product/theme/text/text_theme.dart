import 'package:flutter/material.dart';

abstract class ITextTheme {
  final Color? primaryColor;
  late final TextTheme data;
  TextStyle get displayLarge;
  TextStyle get displayMedium;
  TextStyle get displaySmall;
  TextStyle get headlineMedium;
  TextStyle get headlineSmall;
  TextStyle get headline6;
  TextStyle get titleMedium;
  TextStyle get titleSmall;
  TextStyle get bodyLarge;
  String get fontFamily;

  ITextTheme(this.primaryColor);
}
