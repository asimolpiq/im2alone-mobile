import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/controller/auth_controller.dart';
import 'package:im2alone/core/controller/fragment_controller.dart';
import 'package:im2alone/views/feeds/feeds_view.dart';
import 'package:im2alone/views/fragments/auth_fragment/auth_fragment.dart';
import 'package:im2alone/views/search/search_view.dart';

import '../../my_diary/my_diary_view.dart';
import '../main_view.dart';

abstract class MainViewModel extends State<MainView> with SingleTickerProviderStateMixin {
  RxInt currentIndex = 0.obs;
  FragmentController fragmentController = Get.put(FragmentController(), tag: "fragmentmanager");
  AuthController authController = Get.find(tag: "authmanager");
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: pages.length, vsync: this);
    tabController.addListener(() {
      currentIndex.value = tabController.index;
    });
  }

  final List<Widget> pages = [
    const FeedsView(),
    const MyDiaryView(),
    const SearchView(),
    const AuthFragment(),
  ];
}
