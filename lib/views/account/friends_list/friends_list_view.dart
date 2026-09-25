import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/model/user_utils/friend_list_response_model.dart';
import 'package:im2alone/views/account/user_profile/user_profile_view.dart';

import '../../../product/components/appbar/custom_appbar.dart';
import '../../../product/config/config.dart';
import '../../../product/consts/paddings/project_paddings.dart';
import 'viewmodel/friends_list_viewmodel.dart';

class FriendsListView extends StatefulWidget {
  final String title;
  final String emptyMessageKey;
  final Future<FriendListResponseModel> Function() fetcher;
  const FriendsListView({
    super.key,
    required this.title,
    required this.emptyMessageKey,
    required this.fetcher,
  });

  @override
  State<FriendsListView> createState() => _FriendsListViewState();
}

class _FriendsListViewState extends FriendsListViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: widget.title),
      body: Padding(
        padding: const ProjectPaddings.all16(),
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          color: Theme.of(context).colorScheme.primary,
          onRefresh: () async {
            await fetchFriends();
          },
          child: Obx(
            () => (!isLoading.value)
                ? friends.isNotEmpty
                    ? ListView.builder(
                        itemCount: friends.length,
                        itemBuilder: (BuildContext context, int index) {
                          final user = friends[index];
                          return Card(
                            elevation: 0,
                            color: Theme.of(context).colorScheme.secondary,
                            child: ListTile(
                              onTap: () => Get.to(
                                  () => UserProfileView(user: user)),
                              leading: CircleAvatar(
                                backgroundImage: user.pp != null
                                    ? NetworkImage(
                                            Config['SITE_URL'] + user.pp!)
                                        as ImageProvider<Object>?
                                    : const AssetImage('assets/empty_pp.png'),
                              ),
                              title: Text(
                                user.username ?? "",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              ),
                              subtitle: (user.bio ?? "").isNotEmpty
                                  ? Text(
                                      user.bio!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface),
                                    )
                                  : null,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(widget.emptyMessageKey.tr),
                      )
                : Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
