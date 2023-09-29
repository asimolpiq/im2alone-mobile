import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/model/user_utils/notification_model.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';

import '../../config/config.dart';
import '../../consts/paddings/project_paddings.dart';
import 'viewmodel/notification_card_viewmodel.dart';

class NotificationCard extends StatefulWidget {
  final NotificationModel notification;
  const NotificationCard({super.key, required this.notification});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends FriendRequestCardViewmodel {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding: const ProjectPaddings.all16(),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: widget.notification.pp != null
                        ? NetworkImage(Config['SITE_URL'] + widget.notification.pp) as ImageProvider<Object>?
                        : const AssetImage(
                            'assets/empty_pp.png',
                          ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      AutoSizeText(
                        widget.notification.username ?? "No username",
                        maxFontSize: 30,
                        minFontSize: 25,
                        style: TextStyle(color: Theme.of(context).colorScheme.surface),
                      ),
                      AutoSizeText(
                        (widget.notification.bio ?? "-") != "" ? widget.notification.bio! : "No bio",
                        maxFontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(color: Theme.of(context).colorScheme.surface),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const ProjectSpacers.spacer5(),
            Divider(
              thickness: .4,
              color: Theme.of(context).colorScheme.surface,
              indent: Get.size.width * .03,
              endIndent: Get.size.width * .03,
            ),
            const ProjectSpacers.spacer5(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => acceptFriend(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  child: Padding(
                    padding: const ProjectPaddings.horiztontal16(),
                    child: Text(
                      'accept'.tr,
                      style: TextStyle(color: Colors.greenAccent.shade400, fontSize: 24),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => ignoreFriend(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  child: Padding(
                    padding: const ProjectPaddings.horiztontal16(),
                    child: Text(
                      'ignore'.tr,
                      style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 24),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
