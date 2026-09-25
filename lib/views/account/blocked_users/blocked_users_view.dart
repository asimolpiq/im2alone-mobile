import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../product/components/appbar/custom_appbar.dart';
import '../../../product/config/config.dart';
import '../../../product/consts/paddings/project_paddings.dart';
import 'viewmodel/blocked_users_viewmodel.dart';

class BlockedUsersView extends StatefulWidget {
  const BlockedUsersView({super.key});

  @override
  State<BlockedUsersView> createState() => _BlockedUsersViewState();
}

class _BlockedUsersViewState extends BlockedUsersViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "blocked_users".tr),
      body: Padding(
        padding: const ProjectPaddings.all16(),
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          color: Theme.of(context).colorScheme.primary,
          onRefresh: () async {
            await getBlockedUsers();
          },
          child: Obx(
            () => (!isLoading.value)
                ? blockedUsers.isNotEmpty
                    ? ListView.builder(
                        itemCount: blockedUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          final user = blockedUsers[index];
                          return Card(
                            elevation: 0,
                            color: Theme.of(context).colorScheme.secondary,
                            child: ListTile(
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
                              trailing: ElevatedButton(
                                onPressed: () => unblockUser(user),
                                child: Text('unblock'.tr),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text("no_blocked_users".tr),
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
