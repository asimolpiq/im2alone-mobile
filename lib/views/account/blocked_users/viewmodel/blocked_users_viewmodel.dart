import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/request_helper.dart';
import '../../../../model/user_utils/blocked_user_model.dart';
import '../../../../product/components/snackbar/custom_snacbars.dart';
import '../../../../service/user/user_service.dart';
import '../blocked_users_view.dart';

abstract class BlockedUsersViewmodel extends State<BlockedUsersView> {
  late UserService userService;
  RxList<BlockedUserModel> blockedUsers = <BlockedUserModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    userService = UserService(RequestHelper().dio);
    getBlockedUsers();
  }

  getBlockedUsers() async {
    isLoading.value = true;
    final response = await userService.getBlockedUsers();
    blockedUsers.value = response.blockedUsers ?? [];
    isLoading.value = false;
  }

  unblockUser(BlockedUserModel user) async {
    final success = await userService.unblockUser(user.id ?? "");
    if (success) {
      blockedUsers.remove(user);
      Get.showSnackbar(
          CustomSnackbars.successSnack(message: 'user_unblocked'.tr));
    } else {
      Get.showSnackbar(
          CustomSnackbars.errorSnack(error: 'user_unblock_failed'.tr));
    }
  }
}
