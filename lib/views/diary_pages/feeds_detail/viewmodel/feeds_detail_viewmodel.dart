import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/helpers/request_helper.dart';
import 'package:im2alone/service/feeds/feeds_service.dart';

import '../../../../core/controller/auth_controller.dart';
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
      widget.callback != null ? widget.callback!() : null;
      Get.back();
      Get.snackbar("Success", "Diary deleted successfully!");
    } else {
      Get.snackbar("Error", "Something went wrong");
    }
  }
}
