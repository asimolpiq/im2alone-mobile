import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../model/auth/user_model.dart';
import '../../config/config.dart';
import '../../consts/paddings/project_paddings.dart';

class SearchProfileWidget extends StatelessWidget {
  final User user;
  const SearchProfileWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding: const ProjectPaddings.all8(),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      user.pp != "empty"
                          ? Config['SITE_URL'] + user.pp
                          : "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        user.username ?? "No username",
                        style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.surface),
                      ),
                      AutoSizeText(
                        user.bio ?? "-",
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
          ],
        ),
      ),
    );
  }
}
