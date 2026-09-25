part of './my_account_view.dart';

Future<FriendListResponseModel> _fetchFollowers() =>
    UserService(RequestHelper().dio).getFollowers();

Future<FriendListResponseModel> _fetchFollowing() =>
    UserService(RequestHelper().dio).getFollowing();

Card _profileHeader(BuildContext context, String? username, String? bio,
    String? pp, UserStatsModel? userStats) {
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
                  backgroundImage: pp != null
                      ? NetworkImage(Config['SITE_URL'] + pp)
                          as ImageProvider<Object>?
                      : const AssetImage('assets/empty_pp.png'),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      username ?? "No username",
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.surface),
                    ),
                    AutoSizeText(
                      bio ?? "-",
                      maxFontSize: 14,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.surface),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const ProjectSpacers.spacer10(),
          Divider(
            thickness: .7,
            color: Theme.of(context).colorScheme.surface,
            indent: Get.width * 0.05,
            endIndent: Get.width * 0.05,
          ),
          const ProjectSpacers.spacer10(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("diarys".tr),
                  Text(
                      userStats != null ? "${userStats.diaryCount ?? 0}" : "0"),
                ],
              ),
              InkWell(
                onTap: () => Get.to(() => FriendsListView(
                      title: 'followers'.tr,
                      emptyMessageKey: 'no_followers',
                      fetcher: _fetchFollowers,
                    )),
                child: Column(
                  children: [
                    Text("followers".tr),
                    Text(userStats != null
                        ? "${userStats.followerCount ?? 0}"
                        : "0"),
                  ],
                ),
              ),
              InkWell(
                onTap: () => Get.to(() => FriendsListView(
                      title: 'followings'.tr,
                      emptyMessageKey: 'no_following',
                      fetcher: _fetchFollowing,
                    )),
                child: Column(
                  children: [
                    Text("followings".tr),
                    Text(userStats != null
                        ? "${userStats.followingCount ?? 0}"
                        : "0"),
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
