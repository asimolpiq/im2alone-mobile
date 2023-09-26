import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:im2alone/product/consts/spacers/project_spacers.dart';

import '../../../model/auth/user_model.dart';
import '../../config/config.dart';
import '../../consts/paddings/project_paddings.dart';
import 'viewmodel/search_profile_widget_viewmodel.dart';

class SearchProfileWidget extends StatefulWidget {
  final User user;
  const SearchProfileWidget({super.key, required this.user});

  @override
  State<SearchProfileWidget> createState() => _SearchProfileWidgetState();
}

class _SearchProfileWidgetState extends SearchProfileWidgetViewmodel {
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
                    backgroundImage: widget.user.pp != null
                        ? NetworkImage(Config['SITE_URL'] + widget.user.pp) as ImageProvider<Object>?
                        : const AssetImage('assets/empty_pp.png'),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.user.username ?? "No username",
                        style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.surface),
                      ),
                      AutoSizeText(
                        (widget.user.bio ?? "-") != "" ? widget.user.bio! : "No bio",
                        maxFontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(color: Theme.of(context).colorScheme.surface),
                      ),
                      const ProjectSpacers.spacer5(),
                      widget.user.isFriend != null
                          ? (!widget.user.isFriend!)
                              ? ElevatedButton(
                                  onPressed: () => addUserFriend(widget.user.id ?? ""),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                  ),
                                  child: Padding(
                                    padding: const ProjectPaddings.horiztontal16(),
                                    child: Text('add_friend'.tr),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () => deleteFriend(widget.user.id ?? ""),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                  ),
                                  child: Padding(
                                    padding: const ProjectPaddings.horiztontal16(),
                                    child: Text('delete_friend'.tr,
                                        style: TextStyle(color: Theme.of(context).colorScheme.error)),
                                  ))
                          : ElevatedButton(
                              onPressed: () => deleteFriend(widget.user.id ?? ""),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                              ),
                              child: Padding(
                                  padding: const ProjectPaddings.horiztontal16(),
                                  child: AutoSizeText(
                                    'friend_request_sended'.tr,
                                    maxLines: 1,
                                  )))
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
