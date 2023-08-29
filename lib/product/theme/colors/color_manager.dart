import 'package:flutter/material.dart';

part './kind/light_color.dart';

@immutable
class _AppColors {
  final Color white = const Color(0xffffffff);
  final Color green = const Color(0xff7bed8d);
  final Color mediumGrey = const Color(0xffa6bcd0);
  final Color mediumGreyBold = const Color(0xff748a9d);
  final Color lighterGrey = const Color(0xfff0f4f8);
  final Color lightGrey = const Color(0xffdbe2ed);
  final Color darkerGrey = const Color(0xff404e5a);
  final Color darkGrey = const Color(0xff4e5d6a);
  final Color warmPink = const Color(0xfff54675);
  final Color purplishPink = const Color(0xffe43eba);
  final Color dark = const Color(0xff2a2a38);
  final Color crispCyan = const Color(0x0028ffff);
  final Color gunMetal = const Color(0xff2a2a37);
  final Color fatTuesday = const Color(0xff312539);
  final Color lightBlue = const Color(0xff60D7F8);
}

abstract class IColors {
  _AppColors get colors;
  Color? scaffoldBackgroundColor;
  Color? appBarColor;
  Color? tabBarColor;
  Color? tabbarSelectedColor;
  Color? tabbarNormalColor;
  Brightness? brightness;
  ColorScheme get buttonColorScheme;
  Color get inputFilledColor;
  Color get comboColor;
  Color get dividerColor;
  Color get tabbarBackgroundColor;
  Color get textColor;
  Color? fabColor;
  Color get scrollBarColor;
  ColorScheme? colorScheme;
  Color get iconColor;
}

class ColorName {
  ColorName._();

  /// Color: #1fd7de
  static const Color aqua = Color(0xFF1FD7DE);

  /// Color: #2a2a38
  static const Color dark = Color(0xFF2A2A38);

  /// Color: #885efd
  static const Color lighterPurple = Color(0xFF885EFD);

  /// Color: #ffbf9b
  static const Color paleSalmon = Color(0xFFFFBF9B);

  /// Color: #e43eba
  static const Color purplePink = Color(0xFFE43EBA);

  /// Color: #fe3567
  static const Color reddishPink = Color(0xFFFE3567);

  /// Color: #01a8c4
  static const Color turquoiseBlue = Color(0xFF01A8C4);

  /// Color: #f54675
  static const Color warmPink = Color(0xFFF54675);

  /// Color: #fafafa
  static const Color white = Color(0xFFFAFAFA);

  /// Color: #fbfe7f
  static const Color yellowishTan = Color(0xFFFBFE7F);
}
