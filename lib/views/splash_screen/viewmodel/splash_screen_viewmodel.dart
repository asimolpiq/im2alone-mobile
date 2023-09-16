import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/views/auth/login/login_view.dart';
import 'package:im2alone/views/main_view/main_view.dart';

import '../../../core/controller/auth_controller.dart';
import '../../../core/controller/fragment_controller.dart';
import '../../../core/helpers/caching_manager.dart';
import '../../../core/helpers/request_helper.dart';
import '../../../service/auth/auth_service.dart';
import '../splash_screen.dart';

abstract class SplashViewmodel extends State<SplashScreen> with CachingManager {
  final AuthController authController = Get.put(AuthController(), tag: "authmanager");
  FragmentController fragmentController = Get.put(FragmentController(), tag: "fragmentmanager");

  RxBool isLoaded = false.obs;

  late AuthService authService;

  @override
  void initState() {
    super.initState();
    authController;
    final dio = RequestHelper().dio;
    authService = AuthService(dio);
    getUserIfTokenExists();
  }

  langControl() async {
    final lang = await getLocale();
    if (lang == null) {
      await saveLocale(Get.deviceLocale.toString());
      Get.updateLocale(Get.deviceLocale ?? const Locale('en', 'US'));
    } else {
      Get.updateLocale(Locale(lang));
    }
  }

  getUserIfTokenExists() async {
    final token = await getToken().whenComplete(() => isLoaded.value = true);
    if (token != null) {
      final response = await authService.getUser();
      if (response.error == null && response.user != null) {
        authController.currentUser.value = response.user!;
        authController.isLogin.value = true;
        await saveToken(response.user?.token!);
        await Future.delayed(const Duration(seconds: 4));
        Get.offAll(() => const MainView());
      } else {
        await Future.delayed(const Duration(seconds: 4));
        Get.offAll(() => const LoginView());
      }
    } else {
      await Future.delayed(const Duration(seconds: 4));
      Get.offAll(() => const LoginView());
    }
  }
}
