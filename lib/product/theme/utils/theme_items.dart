part of '../project_theme.dart';

class _AppBarTheme extends AppBarTheme {
  const _AppBarTheme()
      : super(
            centerTitle: true,
            surfaceTintColor: AppColors.secondary,
            backgroundColor: AppColors.secondary,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ));
}

class _BottomNavBarThemeData extends BottomNavigationBarThemeData {
  const _BottomNavBarThemeData()
      : super(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.secondary,
          selectedIconTheme: const IconThemeData(
            color: AppColors.white,
          ),
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.primary,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        );
}

class _CardTheme extends CardTheme {
  const _CardTheme()
      : super(
          elevation: 4,
          shadowColor: AppColors.secondary,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              side: BorderSide(
                color: AppColors.secondary,
                width: 0.15,
              )),
          color: AppColors.white,
          surfaceTintColor: AppColors.white,
        );
}

class _TextTheme extends TextTheme {
  const _TextTheme()
      : super(
          headlineLarge: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
          headlineMedium: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
          headlineSmall: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        );
}

class _ElevatedButtonTheme extends ElevatedButtonThemeData {
  _ElevatedButtonTheme()
      : super(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: ProjectRadius.circular30(),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              AppColors.secondary,
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        );
}