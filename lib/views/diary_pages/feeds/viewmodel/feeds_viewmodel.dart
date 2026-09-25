import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/controller/auth_controller.dart';
import '../../../../core/helpers/diary_sync_manager.dart';
import '../../../../core/helpers/request_helper.dart';
import '../../../../model/feeds/feeds_model.dart';
import '../../../../product/components/snackbar/custom_snacbars.dart';
import '../../../../service/feeds/feeds_service.dart';
import '../feeds_view.dart';
import 'package:flutter/material.dart';

abstract class FeedsViewModel extends State<FeedsView> with DiarySyncManager {
  final AuthController authController = Get.find(tag: "authmanager");
  late FeedsService feedsService;
  RxList<FeedsModel> feedsList = <FeedsModel>[].obs;
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
    if (!await isOnline()) {
      final cached = await getCachedAllFeeds();
      feedsList.value = cached;
      if (cached.isNotEmpty) {
        Get.showSnackbar(
            CustomSnackbars.errorSnack(error: 'offline_showing_cached'.tr));
      }
      isLoading.value = false;
      return;
    }
    final response = await feedsService.getAllDiary();
    if (response.error == null) {
      feedsList.value = response.feeds ?? <FeedsModel>[];
      await cacheAllFeeds(feedsList);
    } else {
      feedsList.value = <FeedsModel>[];
    }
    isLoading.value = false;
  }

  toggleLike(int index) async {
    final feed = feedsList[index];
    final id = feed.id;
    if (id == null) return;
    final previousLiked = feed.liked ?? false;
    final previousLikes = feed.likes ?? 0;
    feed.liked = !previousLiked;
    feed.likes = previousLiked ? previousLikes - 1 : previousLikes + 1;
    feedsList.refresh();

    final result = await feedsService.toggleLike(id);
    if (result.success) {
      feed.liked = result.liked;
      feed.likes = result.count;
    } else {
      feed.liked = previousLiked;
      feed.likes = previousLikes;
    }
    feedsList.refresh();
  }
}
