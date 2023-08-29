part of '../color_manager.dart';

class LightColors implements IColors {
  @override
  final _AppColors colors = _AppColors();

  @override
  ColorScheme? colorScheme;
  @override
  Color? appBarColor;

  @override
  Color? scaffoldBackgroundColor;

  @override
  Color? tabBarColor;

  @override
  Color? fabColor;

  @override
  Color? tabbarNormalColor;

  @override
  Color? tabbarSelectedColor;

  @override
  final Color iconColor = ColorName.purplePink;

  @override
  late ColorScheme buttonColorScheme;

  @override
  Brightness? brightness;

  @override
  late Color inputFilledColor;

  @override
  late Color comboColor;

  @override
  late Color dividerColor;

  @override
  Color scrollBarColor = ColorName.white;

  @override
  Color textColor = ColorName.white;

  @override
  late Color tabbarBackgroundColor;

  LightColors() {
    buttonColorScheme = ColorScheme.light(primary: colors.warmPink, secondary: colors.purplishPink);
    tabbarBackgroundColor = colors.fatTuesday;

    dividerColor = colors.white.withOpacity(0.16);
    inputFilledColor = colors.white.withOpacity(0.16);
    comboColor = colors.dark;
    appBarColor = colors.white;
    scaffoldBackgroundColor = colors.white;
    tabBarColor = colors.green;
    tabbarNormalColor = colors.darkerGrey;
    tabbarSelectedColor = colors.green;
    fabColor = colors.purplishPink;

    colorScheme = const ColorScheme.light().copyWith(
      primary: colors.warmPink,
      onPrimary: colors.green,
      onPrimaryContainer: colors.crispCyan,
      onSecondary: colors.white, //x
      onTertiaryContainer: colors.white.withOpacity(.5),
      onErrorContainer: colors.darkerGrey,
      onError: ColorName.white.withOpacity(.16),
      error: colors.gunMetal,
      onSurfaceVariant: const Color(0xff010111), //xx
      onSurface: colors.mediumGreyBold, //xx
      tertiary: colors.warmPink, //x
      onTertiary: colors.purplishPink, // x
      errorContainer: colors.fatTuesday, //x
      secondaryContainer: colors.lightGrey,
      inverseSurface: const Color(0xff00392a3f), //xx
      primaryContainer: colors.white.withOpacity(.6), //x
      onInverseSurface: const Color(0xff392a3f), //x
      tertiaryContainer: ColorName.reddishPink, //x
      outline: colors.lightBlue, //x
      surfaceVariant: const Color(0xff2A2A37), //x,
      scrim: const Color(0xff706071),
      outlineVariant: const Color(0xff43424e),
      onSecondaryContainer: colors.white.withOpacity(0.1), //x
    );
    brightness = Brightness.light;
  }
}
