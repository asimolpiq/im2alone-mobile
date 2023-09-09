import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:im2alone/views/splash_screen/splash_screen.dart';
import 'package:im2alone/product/config/config.dart';
import 'product/localization/translate.dart';
import 'product/theme/project_theme.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Config['APP_NAME'],
      debugShowCheckedModeBanner: false,
      theme: ProjectTheme.createTheme(),
      home: const SplashScreen(),
      translations: ProductTranslations(),
      locale: const Locale('tr', 'TR'),
    );
  }
}
