import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/controller/fragment_controller.dart';
import 'package:im2alone/core/helpers/caching_manager.dart';
import 'package:im2alone/core/helpers/request_helper.dart';
import 'package:im2alone/service/user/user_service.dart';
import '../friend_request_view.dart';

abstract class FriendRequestsViewmodel extends State<FriendRequestView>
    with CachingManager {
  late UserService userService;
  RxBool isLoading = false.obs;
  final FragmentController fragmentController = Get.find(tag: "fragmentmanager");
  @override
  void initState() {
    super.initState();
    userService = UserService(RequestHelper().dio);
    getNotifications();
  }

  getNotifications() async {
    isLoading.value = true;
    final response = await userService.getNotifications();
    if (response.error == null) {
      fragmentController.notifications.value = response.notifications ?? [];
      isLoading.value = false;
      markNotificationsSeen(
        (response.notifications ?? [])
            .map((notification) => notification.id ?? "")
            .toList(),
      );
    } else {
      isLoading.value = false;
    }
  }
}
