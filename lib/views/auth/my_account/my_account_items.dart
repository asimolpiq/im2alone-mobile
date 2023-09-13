part of './my_account_view.dart';

Card _profileHeader(BuildContext context, String? username, String? bio, String? pp) {
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
                    Config['SITE_URL'] + pp ??
                        "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      username ?? "No username",
                      style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.surface),
                    ),
                    AutoSizeText(
                      bio ?? "-",
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
          const ProjectSpacers.spacer10(),
          Divider(
            thickness: .7,
            color: Theme.of(context).colorScheme.surface,
            indent: Get.width * 0.05,
            endIndent: Get.width * 0.05,
          ),
          const ProjectSpacers.spacer10(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Günlük"),
              Text("Takipçi"),
              Text("Takip"),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("12"),
              Text("12"),
              Text("12"),
            ],
          )
        ],
      ),
    ),
  );
}
