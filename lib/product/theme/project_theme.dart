import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../consts/radius/project_radius.dart';
import 'colors/app_colors.dart';
import 'colors/project_color_scheme.dart';
part 'utils/theme_items.dart';

abstract class ProjectTheme {
  static ThemeData createTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: ProjectColorsScheme().appScheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const _AppBarTheme(),
        elevatedButtonTheme: _ElevatedButtonTheme(),
        scaffoldBackgroundColor: AppColors.background,
        cardTheme: const _CardTheme(),
        canvasColor: AppColors.white,
        textTheme: const _TextTheme(),
        iconTheme: const _IconTheme(),
        listTileTheme: const _ListileTheme(),
        fontFamily: "Comfortaa",
        bottomNavigationBarTheme: const _BottomNavBarThemeData(),
        splashColor: AppColors.transparent,
      );
}
