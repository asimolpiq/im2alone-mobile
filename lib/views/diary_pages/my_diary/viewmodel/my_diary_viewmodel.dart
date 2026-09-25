import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/model/feeds/feeds_model.dart';
import 'package:im2alone/model/feeds/pending_diary_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/helpers/diary_sync_manager.dart';
import '../../../../core/helpers/request_helper.dart';
import '../../../../product/components/snackbar/custom_snacbars.dart';
import '../../../../service/feeds/feeds_service.dart';
import '../my_diary_view.dart';

abstract class MyDiaryViewmodel extends State<MyDiaryView>
    with DiarySyncManager {
  late FeedsService feedsService;
  RxList<FeedsModel> feedsList = <FeedsModel>[].obs;
  RxList<PendingDiaryModel> pendingDiaries = <PendingDiaryModel>[].obs;
  RxBool isLoading = false.obs;
  final Map<int, bool> webViewCompletedMap = {};
  final Map<int, WebViewController> webViewControllers = {};

  bool isWebViewCompleted(int index) => webViewCompletedMap[index] ?? false;

  setWebViewCompleted(int index) {
    if (!mounted) return;
    setState(() {
      webViewCompletedMap[index] = true;
    });
  }

  WebViewController webViewControllerFor(int index, String url) {
    final existing = webViewControllers[index];
    if (existing != null) {
      return existing;
    }
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (progress == 100) {
              setWebViewCompleted(index);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    webViewControllers[index] = controller;
    return controller;
  }

  @override
  void initState() {
    feedsService = FeedsService(RequestHelper().dio);
    getMyDiary();
    super.initState();
  }

  getMyDiary() async {
    isLoading.value = true;
    webViewCompletedMap.clear();
    webViewControllers.clear();
    final sentCount = await flushPendingDiaries();
    if (sentCount > 0) {
      Get.showSnackbar(
          CustomSnackbars.successSnack(message: 'pending_diaries_sent'.tr));
    }
    pendingDiaries.value = await getPendingDiaries();

    if (!await isOnline()) {
      final cached = await getCachedMyDiary();
      feedsList.value = cached;
      if (cached.isNotEmpty) {
        Get.showSnackbar(
            CustomSnackbars.errorSnack(error: 'offline_showing_cached'.tr));
      }
      isLoading.value = false;
      return;
    }

    final response = await feedsService.getMyDiary();
    if (response.error == null) {
      feedsList.value = response.feeds ?? <FeedsModel>[];
      await cacheMyDiary(feedsList);
    } else {
      feedsList.value = <FeedsModel>[];
    }
    isLoading.value = false;
  }
}
