import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/controller/fragment_controller.dart';
import 'package:im2alone/core/helpers/request_helper.dart';
import 'package:im2alone/product/components/snackbar/custom_snacbars.dart';
import 'package:im2alone/service/user/user_service.dart';

import '../notification_profile_view.dart';

abstract class NotificationProfileViewmodel
    extends State<NotificationProfileView> {
  final FragmentController fragmentController =
      Get.find(tag: "fragmentmanager");
  late UserService userService;

  @override
  void initState() {
    super.initState();
    userService = UserService(RequestHelper().dio);
  }

  acceptFriend() async {
    final response =
        await userService.acceptFriend(widget.notification.friendId ?? "");
    if (response) {
      fragmentController.notifications
          .removeWhere((e) => e.friendId == widget.notification.friendId);
      Get.back();
    } else {
      Get.showSnackbar(CustomSnackbars.errorSnack(
          error: "error_accepting_friend_request".tr));
    }
  }

  ignoreFriend() async {
    final response =
        await userService.ignoreFriend(widget.notification.friendId ?? "");
    if (response) {
      fragmentController.notifications
          .removeWhere((e) => e.friendId == widget.notification.friendId);
      Get.back();
    } else {
      Get.showSnackbar(CustomSnackbars.errorSnack(
          error: "error_ignoring_friend_request".tr));
    }
  }

  blockUser() async {
    final response =
        await userService.blockUser(widget.notification.friendId ?? "");
    if (response) {
      fragmentController.notifications
          .removeWhere((e) => e.friendId == widget.notification.friendId);
      Get.back();
      Get.showSnackbar(CustomSnackbars.successSnack(message: 'user_blocked'.tr));
    } else {
      Get.showSnackbar(
          CustomSnackbars.errorSnack(error: 'user_block_failed'.tr));
    }
  }

  AlertDialog blockConfirmDialog(BuildContext context) {
    return AlertDialog(
      title: Text('block_user_confirm_title'.tr),
      content: Text('block_user_confirm_body'.tr),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('cancel'.tr),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            blockUser();
          },
          child: Text('block'.tr,
              style: TextStyle(color: Theme.of(context).colorScheme.error)),
        ),
      ],
    );
  }
}
