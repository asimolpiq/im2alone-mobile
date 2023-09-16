import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/helpers/request_helper.dart';
import 'package:im2alone/product/components/snackbar/custom_snacbars.dart';
import 'package:im2alone/service/feeds/feeds_service.dart';

import '../write_diary_view.dart';

abstract class WriteDiaryViewmodel extends State<WriteDiaryView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController contentController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController privacyController = TextEditingController();
  RxBool isLoading = false.obs;
  late FeedsService feedsService;
  List<DropdownMenuItem<String>> privacyList = [
    DropdownMenuItem(
      value: '0',
      child: Text('only_me'.tr),
    ),
    DropdownMenuItem(
      value: '1',
      child: Text('only_friends'.tr),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('everyone'.tr),
    ),
  ];

  @override
  void initState() {
    super.initState();
    feedsService = FeedsService(RequestHelper().dio);
  }

  submitDiary({required String content, required String link, required String privacy}) {
    changeLoading();
    feedsService.writeDiary(content: content, link: link, privacy: privacy).then((value) {
      if (value) {
        changeLoading();
        contentController.clear();
        linkController.clear();
        privacyController.clear();
        widget.callback != null ? widget.callback!() : null;
        Get.back();
        Get.showSnackbar(CustomSnackbars.successSnack(message: 'diary_added_successfully'.tr));
      } else {
        changeLoading();
        Get.showSnackbar(CustomSnackbars.errorSnack(error: 'diary_added_error'.tr));
      }
    });
  }

  changeLoading() {
    isLoading.value = !isLoading.value;
  }

  @override
  void dispose() {
    super.dispose();
    contentController.dispose();
    linkController.dispose();
    privacyController.dispose();
  }
}
