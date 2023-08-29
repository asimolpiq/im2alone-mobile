import 'package:flutter/material.dart';

import 'app_colors.dart';

@immutable
class ProjectColorsScheme {
  final ColorScheme appScheme = const ColorScheme(
    primary: AppColors.primary,
    onPrimary: AppColors.primary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.secondary,
    brightness: Brightness.light,
    surface: AppColors.white,
    onSurface: AppColors.secondary,
    background: AppColors.white,
    onBackground: AppColors.secondary,
    error: Colors.red,
    onError: AppColors.white,
  );
}
