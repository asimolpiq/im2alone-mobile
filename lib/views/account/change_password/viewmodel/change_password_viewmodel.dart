import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/views/account/change_password/change_password_view.dart';

import '../../../../core/controller/auth_controller.dart';
import '../../../../core/helpers/request_helper.dart';
import '../../../../product/components/snackbar/custom_snacbars.dart';
import '../../../../service/user/user_service.dart';

abstract class ChangePasswordViewmodel extends State<ChangePasswordView> {
  final AuthController authController = Get.find(tag: "authmanager");
  late UserService userService;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    userService = UserService(RequestHelper().dio);
  }

  changePassword({required String password}) async {
    final result = await userService.changePassword(password);
    if (result) {
      Get.back();
      Get.showSnackbar(CustomSnackbars.successSnack(message: "password_change_success".tr));
    } else {
      Get.showSnackbar(CustomSnackbars.errorSnack(error: "password_change_error".tr));
    }
  }
}
