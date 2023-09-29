import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im2alone/product/theme/colors/app_colors.dart';

enum AuthStates {
  register,
  forgotPassword,
  myAccount,
}

enum AuthTextFieldType {
  username,
  password,
}

// ignore: constant_identifier_names
enum AppImages { logo, empty_pp }

extension AppImagesExtension on AppImages {
  SvgPicture getSvg({
    double height = 100,
    double width = 100,
    BoxFit fit = BoxFit.cover,
    Color color = AppColors.white,
  }) {
    return SvgPicture.asset(
      "assets/$name.svg",
      height: height,
      width: width,
      fit: fit,
      // ignore: deprecated_member_use
      color: color,
    );
  }

  Image getPng({
    double height = 100,
    double width = 100,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      "assets/$name.png",
      height: height,
      width: width,
      fit: fit,
      // ignore: deprecated_member_use
    );
  }

  CircleAvatar getAvatar({double? radius}) {
    return CircleAvatar(
      radius: radius ?? 40,
      backgroundImage: AssetImage("assets/$name.png"),
    );
  }
}

enum CacheManagerKey { token, language }
