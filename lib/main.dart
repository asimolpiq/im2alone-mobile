import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:im2alone/pages/splash_screen/splash_screen.dart';
import 'package:im2alone/product/config/config.dart';
import 'package:im2alone/product/consts/colors/project_colors.dart';

import 'product/localization/translate.dart';

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
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: ProjectColors.primaryColor,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: ProjectColors.primaryColor,
            statusBarColor: ProjectColors.primaryColor,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: ProjectColors.black,
            selectedIconTheme: IconThemeData(color: ProjectColors.black),
            backgroundColor: ProjectColors.primaryColor),
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      translations: ProductTranslations(),
      locale: const Locale('en', 'US'),
    );
  }
}
