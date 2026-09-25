import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/helpers/diary_sync_manager.dart';
import 'package:im2alone/core/helpers/request_helper.dart';
import 'package:im2alone/product/components/snackbar/custom_snacbars.dart';
import 'package:im2alone/service/feeds/feeds_service.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../write_diary_view.dart';

abstract class WriteDiaryViewmodel extends State<WriteDiaryView>
    with DiarySyncManager {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  QuillEditorController contentController = QuillEditorController();
  TextEditingController linkController = TextEditingController();
  TextEditingController privacyController = TextEditingController();
  RxBool isLoading = false.obs;
  bool contentError = false;
  late FeedsService feedsService;
  final List<String> privacyKeys = ['only_me', 'only_friends', 'everyone'];

  @override
  void initState() {
    super.initState();
    feedsService = FeedsService(RequestHelper().dio);
  }

  onSubmitPressed() async {
    final content = await contentController.getText();
    final plainText = content.replaceAll(RegExp(r'<[^>]*>'), '').trim();
    setState(() {
      contentError = plainText.isEmpty;
    });
    if (contentError) {
      return;
    }
    if (!formKey.currentState!.validate()) {
      return;
    }
    submitDiary(
      content: content,
      link: linkController.text,
      privacy: privacyController.text,
    );
  }

  submitDiary(
      {required String content,
      required String link,
      required String privacy}) async {
    changeLoading();
    bool success = false;
    if (await isOnline()) {
      success = await feedsService.writeDiary(
          content: content, link: link, privacy: privacy);
    }
    changeLoading();
    if (success) {
      finishSubmit();
      Get.showSnackbar(
          CustomSnackbars.successSnack(message: 'diary_added_successfully'.tr));
    } else {
      await addPendingDiary(content: content, link: link, privacy: privacy);
      finishSubmit();
      Get.showSnackbar(
          CustomSnackbars.successSnack(message: 'diary_queued_offline'.tr));
    }
  }

  finishSubmit() {
    contentController.clear();
    linkController.clear();
    privacyController.clear();
    widget.callback != null ? widget.callback!() : null;
    Get.back();
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
