import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/controller/auth_controller.dart';
import 'package:im2alone/core/controller/fragment_controller.dart';
import 'package:im2alone/product/mixins/get_user_stats_mixin.dart';

import '../../../../model/user_utils/user_stats_model.dart';
import '../../../../product/components/snackbar/custom_snacbars.dart';
import '../my_account_view.dart';

abstract class MyAccountViewModel extends State<MyAccount> with GetUserStats {
  final AuthController authController = Get.find(tag: "authmanager");
  final FragmentController fragmentController = Get.find(tag: "fragmentmanager");
  Rx<UserStatsModel?> userStats = UserStatsModel().obs;

  @override
  void initState() {
    super.initState();
    getMyStats();
  }

  getMyStats() async {
    final response = await getUserStats(authController.currentUser.value.id ?? "0");
    if (response.error == null) {
      userStats.value = response.userStats ?? UserStatsModel();
    } else {
      CustomSnackbars.errorSnack(error: response.error ?? "error".tr);
    }
  }
}
