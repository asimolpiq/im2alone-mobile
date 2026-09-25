import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/helpers/request_helper.dart';
import 'package:im2alone/service/feeds/feeds_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/controller/auth_controller.dart';
import '../feeds_detail_view.dart';

abstract class FeedsDetailViewmodel extends State<FeedsDetailView> {
  final AuthController authController = Get.find(tag: "authmanager");
  late FeedsService feedsService;
  late WebViewController webViewController;
  bool isCompleted = false;
  late int likes;
  late int views;
  late bool liked;
  @override
  void initState() {
    super.initState();
    feedsService = FeedsService(RequestHelper().dio);
    likes = widget.feed.likes ?? 0;
    views = widget.feed.views ?? 0;
    liked = widget.feed.liked ?? false;
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (progress == 100 && mounted) {
              setState(() {
                isCompleted = true;
              });
            }
          },
        ),
      );
    if ((widget.feed.link ?? "").isNotEmpty) {
      webViewController.loadRequest(Uri.parse(widget.feed.link!));
    }
  }

  toggleLike() async {
    final id = widget.feed.id;
    if (id == null) return;
    final previousLiked = liked;
    final previousLikes = likes;
    setState(() {
      liked = !previousLiked;
      likes = previousLiked ? previousLikes - 1 : previousLikes + 1;
    });

    final result = await feedsService.toggleLike(id);
    if (!mounted) return;
    setState(() {
      if (result.success) {
        liked = result.liked;
        likes = result.count;
      } else {
        liked = previousLiked;
        likes = previousLikes;
      }
    });
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
