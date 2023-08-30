import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/views/main_view/main_view.dart';

import '../../../core/controller/auth_controller.dart';
import '../../../core/helpers/caching_manager.dart';
import '../../../core/helpers/request_helper.dart';
import '../../../service/auth/auth_service.dart';
import '../splash_screen.dart';

abstract class SplashViewmodel extends State<SplashScreen> with CachingManager {
  AuthController authController = Get.put(AuthController(), tag: "authmanager");

  RxBool isLoaded = false.obs;

  late AuthService authService;

  @override
  void initState() {
    super.initState();
    final dio = RequestHelper().dio;
    authService = AuthService(dio);
    getUserIfTokenExists();
    loadAndNavigate();
  }

  getUserIfTokenExists() async {
    final token = await getToken();
    if (token != null) {
      final response = await authService.getUser();
      if (response.error == null && response.user != null) {
        authController.currentUser.value = response.user!;
        authController.isLogin.value = true;
        await saveToken(response.user?.token!);
      }
    }
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
