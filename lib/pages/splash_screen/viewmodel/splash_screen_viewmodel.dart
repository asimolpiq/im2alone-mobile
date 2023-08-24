import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/pages/main_view/main_view.dart';

import '../splash_screen.dart';

abstract class SplashViewmodel extends State<SplashScreen> {
  RxBool isLoaded = false.obs;

  @override
  void initState() {
    super.initState();
    loadAndNavigate();
  }

  loadAndNavigate() async {
    await Future.delayed(const Duration(seconds: 1));
    isLoaded.value = true;
    await Future.delayed(const Duration(seconds: 4)).then(
      (value) => Get.offAll(
        () => const MainView(),
        transition: Transition.zoom,
      ),
    );
  }
}
