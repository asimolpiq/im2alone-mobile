import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/controller/auth_controller.dart';
import 'package:im2alone/core/controller/fragment_controller.dart';
import 'package:im2alone/core/helpers/caching_manager.dart';
import 'package:im2alone/core/helpers/request_helper.dart';
import 'package:im2alone/model/auth/login_request_model.dart';
import 'package:im2alone/product/enums/project_enums.dart';
import 'package:im2alone/service/auth/auth_service.dart';

import '../login_view.dart';

abstract class LoginViewmodel extends State<LoginView> with CachingManager {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find(tag: "authmanager");
  final FragmentController fragmentController = Get.find(tag: "fragmentmanager");
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    final dio = RequestHelper().dio;
    authService = AuthService(dio);
  }

  loginRequest(LoginRequestModel model) async {
    final response = await authService.login(model);

    if (response.error == null && response.user != null) {
      authController.currentUser.value = response.user!;
      authController.isLogin.value = true;
      await saveToken(response.user?.token!);
      fragmentController.authState.value = AuthStates.myAccount;
    } else {
      if (mounted) {
        Get.showSnackbar(GetSnackBar(
          borderRadius: 15,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: kTextTabBarHeight),
          backgroundColor: Theme.of(context).colorScheme.error,
          messageText: Text(
            response.error!,
            style: TextStyle(color: Theme.of(context).colorScheme.surface),
          ),
          duration: const Duration(seconds: 3),
        ));
      }
    }
  }
}
