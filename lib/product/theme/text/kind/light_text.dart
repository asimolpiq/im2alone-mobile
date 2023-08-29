import 'package:flutter/material.dart';

import '../text_theme.dart';

class TextThemeLight implements ITextTheme {
  @override
  late final TextTheme data;

  @override
  TextStyle bodyLarge = const TextStyle(fontSize: 10.0);

  @override
  TextStyle displayLarge = const TextStyle(fontSize: 40, fontWeight: FontWeight.w700);

  @override
  TextStyle displayMedium = const TextStyle(fontSize: 32, fontWeight: FontWeight.w700);

  @override
  TextStyle displaySmall = const TextStyle(fontSize: 22, fontWeight: FontWeight.w900);

  @override
  TextStyle headlineMedium = const TextStyle(fontSize: 20, fontWeight: FontWeight.w800);

  @override
  TextStyle headlineSmall = const TextStyle(fontSize: 18, fontWeight: FontWeight.w900);

  @override
  TextStyle headline6 = const TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

  @override
  TextStyle titleMedium = const TextStyle(fontSize: 14.0);

  @override
  TextStyle titleSmall = const TextStyle(fontSize: 12.0);
  @override
  final Color primaryColor;

  TextThemeLight(this.primaryColor) {
    data = TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: headline6,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
    ).apply(
      bodyColor: primaryColor,
      decorationColor: primaryColor,
      displayColor: primaryColor,
      fontFamily: fontFamily,
    );
  }

  @override
  String fontFamily = 'ProximaNova';
}
