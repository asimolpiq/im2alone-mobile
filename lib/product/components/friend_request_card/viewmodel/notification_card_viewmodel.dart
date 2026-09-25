import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/product/components/snackbar/custom_snacbars.dart';

import '../../../../core/controller/fragment_controller.dart';
import '../../../../core/helpers/request_helper.dart';
import '../../../../service/user/user_service.dart';
import '../notification_card.dart';

abstract class FriendRequestCardViewmodel extends State<NotificationCard> {
  final FragmentController fragmentController = Get.find(tag: "fragmentmanager");
  late UserService userService;
  @override
  void initState() {
    super.initState();
    userService = UserService(RequestHelper().dio);
  }

  acceptFriend() async {
    final response = await userService.acceptFriend(widget.notification.friendId ?? "");
    if (response) {
      fragmentController.notifications.removeWhere((element) => element.friendId == widget.notification.friendId);
    } else {
      Get.showSnackbar(CustomSnackbars.errorSnack(error: "error_accepting_friend_request".tr));
    }
  }

  ignoreFriend() async {
    final response = await userService.ignoreFriend(widget.notification.friendId ?? "");
    if (response) {
      fragmentController.notifications.removeWhere((element) => element.friendId == widget.notification.friendId);
    } else {
      Get.showSnackbar(CustomSnackbars.errorSnack(error: "error_ignoring_friend_request".tr));
    }
  }

  blockUser() async {
    final response = await userService.blockUser(widget.notification.friendId ?? "");
    if (response) {
      fragmentController.notifications.removeWhere((element) => element.friendId == widget.notification.friendId);
      Get.showSnackbar(CustomSnackbars.successSnack(message: 'user_blocked'.tr));
    } else {
      Get.showSnackbar(CustomSnackbars.errorSnack(error: 'user_block_failed'.tr));
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
