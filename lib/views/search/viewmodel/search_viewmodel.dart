import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/request_helper.dart';
import '../../../model/auth/user_model.dart';
import '../../../service/user/user_service.dart';
import '../search_view.dart';

abstract class SearchViewmodel extends State<SearchView> {
  late UserService userService;
  RxList<User> users = <User>[].obs;
  RxBool isLoading = false.obs;
  RxBool isSearch = false.obs;
  @override
  void initState() {
    super.initState();
    userService = UserService(RequestHelper().dio);
  }

  getSearchResult(String query) async {
    isLoading.value = true;
    final result = await userService.search(query);

    if (result.error == null) {
      users.clear();
      users.value = result.users ?? [];
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
