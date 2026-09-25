import 'package:flutter/material.dart';
import 'package:im2alone/model/user_utils/friend_list_model.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';
import 'package:im2alone/product/config/config.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';

class UserProfileView extends StatelessWidget {
  final FriendListModel user;
  const UserProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: user.username ?? ""),
      body: Padding(
        padding: const ProjectPaddings.all16(),
        child: Column(
          children: [
            const ProjectSpacers.spacer30(),
            CircleAvatar(
              radius: 60,
              backgroundImage: user.pp != null
                  ? NetworkImage(Config['SITE_URL'] + user.pp)
                      as ImageProvider<Object>?
                  : const AssetImage('assets/empty_pp.png'),
            ),
            const ProjectSpacers.spacer20(),
            Text(
              user.username ?? "",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.surface),
            ),
            const ProjectSpacers.spacer10(),
            Text(
              (user.bio ?? "").isNotEmpty ? user.bio! : "-",
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.surface),
            ),
          ],
        ),
      ),
    );
  }
}
