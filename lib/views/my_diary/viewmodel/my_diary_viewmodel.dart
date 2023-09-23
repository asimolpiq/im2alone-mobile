import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/model/feeds/feeds_model.dart';
import '../../../core/helpers/request_helper.dart';
import '../../../service/feeds/feeds_service.dart';
import '../my_diary_view.dart';

abstract class MyDiaryViewmodel extends State<MyDiaryView> {
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
    final response = await feedsService.getMyDiary();
    if (response.error == null) {
      feedsList.value = response.feeds ?? [];
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }
}
