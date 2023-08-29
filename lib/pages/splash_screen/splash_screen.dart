import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:im2alone/pages/splash_screen/viewmodel/splash_screen_viewmodel.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends SplashViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Obx(
        () => Center(
          child: Padding(
            padding: ProjectPaddings.padding8,
            child: AnimatedContainer(
              width: !isLoaded.value ? 0 : Get.size.width,
              curve: Curves.bounceOut,
              duration: const Duration(seconds: 4),
              child: SvgPicture.asset(
                "assets/logo.svg",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
