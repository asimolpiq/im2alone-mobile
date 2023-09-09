import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/helpers/request_helper.dart';
import 'package:im2alone/service/feeds/feeds_service.dart';
import 'package:im2alone/views/main_view/main_view.dart';

import '../../../core/controller/auth_controller.dart';
import '../feeds_detail_view.dart';

abstract class FeedsDetailViewmodel extends State<FeedsDetailView> {
  final AuthController authController = Get.find(tag: "authmanager");
  late FeedsService feedsService;
  bool isCompleted = false;
  @override
  void initState() {
    super.initState();
    feedsService = FeedsService(RequestHelper().dio);
  }

  deleteThisDiary(String id) async {
    final response = await feedsService.deleteDiary(id);
    if (response) {
      Get.offAll(const MainView());
      Get.snackbar("Success", "Diary deleted successfully!");
    } else {
      Get.snackbar("Error", "Something went wrong");
    }
  }
}
