import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum MainStates {
  feeds,
  myDiary,
  myProfile,
  addDiary,
}

enum AuthStates {
  login,
  register,
  forgotPassword,
  myAccount,
}

enum AuthTextFieldType {
  email,
  password,
}

enum AppImages {
  logo,
}

extension AppImagesExtension on AppImages {
  SvgPicture getSvg({double height = 100, double width = 100, BoxFit fit = BoxFit.cover}) {
    return SvgPicture.asset(
      "assets/$name.svg",
      height: height,
      width: width,
      fit: fit,
    );
  }
}
