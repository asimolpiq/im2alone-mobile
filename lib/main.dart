import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/pages/splash_screen/splash_screen.dart';
import 'package:im2alone/product/config/config.dart';
import 'product/localization/translate.dart';
import 'product/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Config['APP_NAME']!,
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.createTheme(AppThemeLight()),
      home: const SplashScreen(),
      translations: ProductTranslations(),
      locale: const Locale('en', 'US'),
    );
  }
}
