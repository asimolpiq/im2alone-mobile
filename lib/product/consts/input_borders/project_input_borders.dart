import 'package:flutter/material.dart';
import 'package:im2alone/product/consts/radius/project_radius.dart';
import 'package:im2alone/product/theme/colors/app_colors.dart';

class ProjectInputBorder extends OutlineInputBorder {
  ProjectInputBorder.authBorder()
      : super(
          borderRadius: ProjectRadius.circular30(),
          borderSide: const BorderSide(
            color: AppColors.white,
          ),
        );
  ProjectInputBorder.formBorder()
      : super(
          borderRadius: ProjectRadius.circular15(),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        );
}
