import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/request_helper.dart';
import '../../../../service/user/user_service.dart';
import '../../snackbar/custom_snacbars.dart';
import '../search_profile_widget.dart';

abstract class SearchProfileWidgetViewmodel extends State<SearchProfileWidget> {
  late UserService userService;
  @override
  void initState() {
    super.initState();
    userService = UserService(RequestHelper().dio);
  }

  addUserFriend(String userID) async {
    final response = await userService.addFriend(userID);
    if (response) {
      Get.showSnackbar(CustomSnackbars.successSnack(message: 'friend_request_sent'.tr));
    } else {
      Get.showSnackbar(CustomSnackbars.errorSnack(error: 'friend_request_not_sent'.tr));
    }
  }

  deleteFriend(String userID) async {
    final response = await userService.deleteFriend(userID);
    if (response) {
      widget.user.isFriend = false;
      setState(() {});
      Get.showSnackbar(CustomSnackbars.successSnack(message: 'friend_deleted'.tr));
    } else {
      Get.showSnackbar(CustomSnackbars.errorSnack(error: 'friend_not_deleted'.tr));
    }
  }
}
