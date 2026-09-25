import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/model/user_utils/notification_model.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';
import 'package:im2alone/product/config/config.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';

import 'viewmodel/notification_profile_viewmodel.dart';

class NotificationProfileView extends StatefulWidget {
  final NotificationModel notification;
  const NotificationProfileView({super.key, required this.notification});

  @override
  State<NotificationProfileView> createState() =>
      _NotificationProfileViewState();
}

class _NotificationProfileViewState extends NotificationProfileViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: widget.notification.username ?? ""),
      body: Padding(
        padding: const ProjectPaddings.all16(),
        child: Column(
          children: [
            const ProjectSpacers.spacer30(),
            CircleAvatar(
              radius: 60,
              backgroundImage: widget.notification.pp != null
                  ? NetworkImage(Config['SITE_URL'] + widget.notification.pp)
                      as ImageProvider<Object>?
                  : const AssetImage('assets/empty_pp.png'),
            ),
            const ProjectSpacers.spacer20(),
            Text(
              widget.notification.username ?? "",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.surface),
            ),
            const ProjectSpacers.spacer10(),
            Text(
              (widget.notification.bio ?? "").isNotEmpty
                  ? widget.notification.bio!
                  : "-",
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.surface),
            ),
            const ProjectSpacers.spacer30(),
            Text(
              "${widget.notification.username ?? ""} ${'sent_you_friend_request'.tr}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.surface),
            ),
            const ProjectSpacers.spacer20(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => acceptFriend(),
                  child: Text(
                    'accept'.tr,
                    style: TextStyle(color: Colors.greenAccent.shade400),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => ignoreFriend(),
                  child: Text(
                    'ignore'.tr,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => blockConfirmDialog(context),
                  ),
                  child: Text(
                    'block'.tr,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
