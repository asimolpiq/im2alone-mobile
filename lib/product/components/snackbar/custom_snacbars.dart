import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbars {
  static GetSnackBar errorSnack({String? error}) {
    return GetSnackBar(
      borderRadius: 15,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: kTextTabBarHeight),
      backgroundColor: Theme.of(Get.context!).colorScheme.error,
      messageText: Text(
        error ?? "",
        style: TextStyle(color: Theme.of(Get.context!).colorScheme.surface),
      ),
      duration: const Duration(seconds: 3),
    );
  }

  static GetSnackBar successSnack({String? message}) {
    return GetSnackBar(
      borderRadius: 15,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: kTextTabBarHeight),
      backgroundColor: Theme.of(Get.context!).primaryColor,
      messageText: Text(
        message ?? "",
        style: TextStyle(color: Theme.of(Get.context!).colorScheme.secondary),
      ),
      duration: const Duration(seconds: 3),
    );
  }
}
