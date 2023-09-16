import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:im2alone/product/theme/colors/app_colors.dart';

enum MainStates {
  feeds,
  myDiary,
  myProfile,
  addDiary,
}

enum AuthStates {
  register,
  forgotPassword,
  myAccount,
}

enum AuthTextFieldType {
  username,
  password,
}

enum AppImages {
  logo,
}

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
    );
  }
}

enum CacheManagerKey { token, language }
