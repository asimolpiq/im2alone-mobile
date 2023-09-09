import 'package:flutter/material.dart';
import 'package:im2alone/product/theme/colors/app_colors.dart';

import '../../consts/input_borders/project_input_borders.dart';
import '../../consts/paddings/project_paddings.dart';

class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration.textDecoration({required String hintText})
      : super(
          fillColor: AppColors.secondary,
          filled: true,
          enabledBorder: ProjectInputBorder.formBorder(),
          border: ProjectInputBorder.formBorder(),
          labelStyle: const TextStyle(color: AppColors.white),
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.white),
          contentPadding: const ProjectPaddings.all16(),
          focusedBorder: ProjectInputBorder.formBorder(),
        );
  CustomInputDecoration.dropdownDecoration({required String hintText})
      : super(
          fillColor: AppColors.secondary,
          filled: true,
          enabledBorder: ProjectInputBorder.formBorder(),
          border: ProjectInputBorder.formBorder(),
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.white),
          contentPadding: const ProjectPaddings.all16(),
          focusedBorder: ProjectInputBorder.formBorder(),
        );
}
