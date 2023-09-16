import 'package:flutter/material.dart';
import 'package:im2alone/product/theme/colors/app_colors.dart';

import '../../consts/input_borders/project_input_borders.dart';
import '../../consts/paddings/project_paddings.dart';
import '../../theme/project_theme.dart';

class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration.textDecoration([String hintText = ""])
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
  CustomInputDecoration.dropdownDecoration([String hintText = ""])
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

  CustomInputDecoration.searchDecoration([String hintText = "", Widget? prefixIcon])
      : super(
          fillColor: AppColors.secondary,
          filled: true,
          prefixIcon: prefixIcon,
          enabledBorder: ProjectInputBorder.formBorder(),
          border: ProjectInputBorder.formBorder(),
          hintText: hintText,
          hintStyle: ProjectTheme.createTheme().textTheme.titleMedium?.copyWith(color: AppColors.white, fontSize: 22),
          contentPadding: const ProjectPaddings.all16(),
          focusedBorder: ProjectInputBorder.formBorder(),
        );
  CustomInputDecoration.profileInput([String hintText = "", Widget? prefixIcon, Widget? suffixIcon])
      : super(
          fillColor: AppColors.secondary,
          labelText: hintText,
          labelStyle:
              ProjectTheme.createTheme().textTheme.titleMedium?.copyWith(color: AppColors.primary, fontSize: 22),
          filled: true,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: ProjectInputBorder.formBorder(),
          border: ProjectInputBorder.formBorder(),
          hintStyle: ProjectTheme.createTheme().textTheme.titleMedium?.copyWith(color: AppColors.white, fontSize: 22),
          contentPadding: const ProjectPaddings.all16(),
          focusedBorder: ProjectInputBorder.formBorder(),
        );
}
