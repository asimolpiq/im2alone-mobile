import 'package:get/get.dart';

import '../../../../core/helpers/request_helper.dart';
import '../../../../model/feeds/feeds_model.dart';
import '../../../../service/feeds/feeds_service.dart';
import '../feeds_view.dart';
import 'package:flutter/material.dart';

abstract class FeedsViewModel extends State<FeedsView> {
  late FeedsService feedsService;
  RxList<FeedsModel> feedsList = <FeedsModel>[].obs;
  RxBool isLoading = false.obs;
  bool isCompleted = false;
  @override
  void initState() {
    feedsService = FeedsService(RequestHelper().dio);
    getMyDiary();
    super.initState();
  }

  getMyDiary() async {
    isLoading.value = true;
    final response = await feedsService.getAllDiary();
    if (response.error == null) {
      feedsList.value = response.feeds ?? <FeedsModel>[];
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }
}
