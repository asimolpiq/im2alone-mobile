import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:im2alone/product/consts/colors/project_colors.dart';

import 'colors/color_manager.dart';
import 'input/input_decoration.dart';
import 'text/kind/light_text.dart';
import 'text/text_theme.dart';

part './utility/theme_items.dart';

abstract class ThemeManager {
  static ThemeData createTheme(ITheme theme) => ThemeData(
        useMaterial3: true,
        colorScheme: theme.colors.colorScheme,
        fontFamily: theme.textTheme.fontFamily,
        textTheme: theme.textTheme.data,
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(cursorColor: theme.colors.colorScheme?.onSecondary),
        cardTheme: _CardTheme(theme),
        tabBarTheme: _TabBarTheme(theme),
        floatingActionButtonTheme: _FloatingTheme(theme),
        bottomNavigationBarTheme: _BottomNavBarTheme(theme),
        appBarTheme: _AppBarTheme(theme.textTheme.headlineSmall),
        dividerTheme: _DividerTheme(theme),
        popupMenuTheme: _PopupMenuTheme(theme),
        textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: theme.colors.textColor)),
        inputDecorationTheme: CustomInputDecoration(theme.textTheme, theme.colors),
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: theme.colors.fabColor)),
        buttonTheme: ButtonThemeData(colorScheme: theme.colors.buttonColorScheme),
        bottomAppBarTheme: BottomAppBarTheme(color: theme.colors.tabbarBackgroundColor),
      );
}

abstract class ITheme {
  ITextTheme get textTheme;
  IColors get colors;
}

class AppThemeLight extends ITheme {
  @override
  late final ITextTheme textTheme;

  AppThemeLight() {
    textTheme = TextThemeLight(
      ProjectColors.black,
    );
  }

  @override
  IColors get colors => LightColors();
}
