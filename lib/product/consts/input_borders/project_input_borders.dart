import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/product/consts/radius/project_radius.dart';

class ProjectInputBorder extends OutlineInputBorder {
  ProjectInputBorder.authBorder()
      : super(
            borderRadius: ProjectRadius.circular30(),
            borderSide: BorderSide(
              color: Theme.of(Get.context!).colorScheme.secondary,
            ));
}
