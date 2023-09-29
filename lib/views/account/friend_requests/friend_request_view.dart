import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:im2alone/views/account/friend_requests/viewmodel/friend_requests_viewmodel.dart';

import '../../../product/components/friend_request_card/notification_card.dart';

class FriendRequestView extends StatefulWidget {
  const FriendRequestView({super.key});

  @override
  State<FriendRequestView> createState() => _FriendRequestViewState();
}

class _FriendRequestViewState extends FriendRequestsViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(title: "friend_requests".tr),
        body: Padding(
            padding: const ProjectPaddings.all16(),
            child: RefreshIndicator(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              color: Theme.of(context).colorScheme.primary,
              onRefresh: () async {
                await getNotifications();
              },
              child: Obx(
                () => (!isLoading.value)
                    ? fragmentController.notifications.isNotEmpty
                        ? ListView.builder(
                            itemCount: fragmentController.notifications.length,
                            itemBuilder: (BuildContext context, int index) {
                              return NotificationCard(
                                notification: fragmentController.notifications[index],
                              );
                            },
                          )
                        : Center(
                            child: Text("no_friend_requests".tr),
                          )
                    : Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
              ),
            )));
  }
}
