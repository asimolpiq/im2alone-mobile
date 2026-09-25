import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/model/user_utils/friend_list_model.dart';

import '../friends_list_view.dart';

abstract class FriendsListViewmodel extends State<FriendsListView> {
  RxList<FriendListModel> friends = <FriendListModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    fetchFriends();
  }

  fetchFriends() async {
    isLoading.value = true;
    final response = await widget.fetcher();
    friends.value = response.friends ?? [];
    isLoading.value = false;
  }
}
