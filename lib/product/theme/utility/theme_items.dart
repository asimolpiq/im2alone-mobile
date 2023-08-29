part of '../app_theme.dart';

class _AppBarTheme extends AppBarTheme {
  const _AppBarTheme(TextStyle? style)
      : super(
            backgroundColor: ProjectColors.primaryColor,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
            ));
}

class _PopupMenuTheme extends PopupMenuThemeData {
  _PopupMenuTheme(ITheme theme)
      : super(
            color: theme.colors.comboColor,
            elevation: 0,
            textStyle: theme.textTheme.headline6.copyWith(fontWeight: FontWeight.w800));
}

class _TabBarTheme extends TabBarTheme {
  _TabBarTheme(ITheme theme)
      : super(
          labelPadding: EdgeInsets.zero,
          indicator: BoxDecoration(
            border: Border(top: BorderSide(color: theme.colors.colors.warmPink, width: 5.0)),
          ),
        );
}

class _BottomNavBarTheme extends BottomNavigationBarThemeData {
  const _BottomNavBarTheme(ITheme theme)
      : super(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ProjectColors.primaryColor,
          selectedItemColor: ProjectColors.black,
          selectedIconTheme: const IconThemeData(color: ProjectColors.black),
          unselectedItemColor: ProjectColors.black,
        );
}

class _CardTheme extends CardTheme {
  _CardTheme(ITheme theme)
      : super(
            color: theme.colors.colorScheme?.onError,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
}

class _FloatingTheme extends FloatingActionButtonThemeData {
  _FloatingTheme(ITheme theme) : super(backgroundColor: theme.colors.fabColor);
}

class _DividerTheme extends DividerThemeData {
  _DividerTheme(ITheme theme) : super(color: theme.colors.dividerColor, thickness: 2);
}
