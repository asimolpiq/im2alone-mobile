import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/controller/auth_controller.dart';
import 'package:im2alone/core/controller/fragment_controller.dart';
import 'package:im2alone/core/helpers/diary_sync_manager.dart';
import 'package:im2alone/core/helpers/request_helper.dart';
import 'package:im2alone/service/user/user_service.dart';
import 'package:im2alone/views/diary_pages/feeds/feeds_view.dart';
import 'package:im2alone/views/fragments/auth_fragment/auth_fragment.dart';
import 'package:im2alone/views/search/search_view.dart';

import '../../../diary_pages/my_diary/my_diary_view.dart';
import '../main_view.dart';

abstract class MainViewModel extends State<MainView>
    with SingleTickerProviderStateMixin, DiarySyncManager {
  RxInt currentIndex = 0.obs;
  FragmentController fragmentController = Get.find(tag: "fragmentmanager");
  AuthController authController = Get.find(tag: "authmanager");
  late TabController tabController;
  late UserService userService;
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: pages.length, vsync: this);
    tabController.addListener(() {
      currentIndex.value = tabController.index;
    });

    userService = UserService(RequestHelper().dio);
    fetchNotifications();

    flushPendingDiaries();

    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      if (!result.contains(ConnectivityResult.none)) {
        flushPendingDiaries();
      }
    });
  }

  fetchNotifications() async {
    final response = await userService.getNotifications();
    if (response.error == null) {
      fragmentController.notifications.value = response.notifications ?? [];
    }
  }

  @override
  void dispose() {
    connectivitySubscription?.cancel();
    tabController.dispose();
    super.dispose();
  }

  final List<Widget> pages = [
    const FeedsView(),
    const MyDiaryView(),
    const SearchView(),
    const AuthFragment(),
  ];
}
