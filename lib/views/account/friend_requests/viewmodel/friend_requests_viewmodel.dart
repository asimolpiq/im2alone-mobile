import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/helpers/request_helper.dart';
import 'package:im2alone/service/user/user_service.dart';

import '../../../../model/user_utils/notification_model.dart';
import '../friend_request_view.dart';

abstract class FriendRequestsViewmodel extends State<FriendRequestView> {
  late UserService userService;
  RxBool isLoading = false.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
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
      notifications.value = response.notifications ?? [];
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }
}
