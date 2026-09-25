import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:im2alone/product/enums/project_enums.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../../product/components/appbar/custom_appbar.dart';
import '../../../product/components/feed_actions/feed_actions_bar.dart';
import '../../../product/components/moderation/report_block_menu.dart';
import '../../../product/components/notification_bell/notification_bell_button.dart';
import '../../../product/config/config.dart';
import '../../../product/consts/paddings/project_paddings.dart';
import '../../../product/consts/radius/project_radius.dart';
import '../../../product/consts/spacers/project_spacers.dart';
import '../feeds_detail/feeds_detail_view.dart';
import 'viewmodel/feeds_viewmodel.dart';

class FeedsView extends StatefulWidget {
  const FeedsView({super.key});

  @override
  State<FeedsView> createState() => _FeedsViewState();
}

class _FeedsViewState extends FeedsViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          title: 'all_feeds'.tr,
          actions: const [NotificationBellButton()],
        ),
        body: RefreshIndicator(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          color: Theme.of(context).colorScheme.primary,
          onRefresh: () async {
            await getMyDiary();
          },
          child: Padding(
            padding: const ProjectPaddings.all8(),
            child: Obx(
              () => !isLoading.value
                  ? feedsList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: feedsList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 0,
                              color: Theme.of(context).colorScheme.secondary,
                              child: Padding(
                                padding: const ProjectPaddings.all16(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        feedsList[index].pp != null
                                            ? Image.network(Config['SITE_URL'] +
                                                feedsList[index].pp)
                                            : AppImages.empty_pp
                                                .getAvatar(radius: 23),
                                        SizedBox(
                                          width: Get.size.width * 0.02,
                                        ),
                                        Expanded(
                                          child: AutoSizeText(
                                              feedsList[index].friendName ??
                                                  "No username",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              maxFontSize: 20,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium),
                                        ),
                                        if (feedsList[index].userId !=
                                                authController
                                                    .currentUser.value.id &&
                                            feedsList[index].userId != null)
                                          ReportBlockMenu(
                                            userId: feedsList[index].userId!,
                                            feedId: feedsList[index].id,
                                            onBlocked: () => getMyDiary(),
                                          ),
                                      ],
                                    ),
                                    const ProjectSpacers.spacer5(),
                                    Divider(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      thickness: .4,
                                    ),
                                    HtmlWidget(
                                      feedsList[index].content ?? "",
                                      customStylesBuilder: (element) {
                                        if (element.outerHtml.contains('<p>')) {
                                          return {
                                            'max-lines': '2',
                                            "text-overflow": "ellipsis",
                                          };
                                        }
                                        return null;
                                      },
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const ProjectSpacers.spacer10(),
                                    Offstage(
                                        offstage: isWebViewCompleted(index),
                                        child:
                                            const CircularProgressIndicator()),
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      height: isWebViewCompleted(index)
                                          ? Get.size.height * 0.086
                                          : 0,
                                      child: ClipRRect(
                                        borderRadius:
                                            ProjectRadius.circular15(),
                                        child: (feedsList[index].link ?? "")
                                                .isEmpty
                                            ? const SizedBox.shrink()
                                            : WebViewWidget(
                                                controller:
                                                    webViewControllerFor(
                                                  index,
                                                  feedsList[index].link ?? "",
                                                ),
                                              ),
                                      ),
                                    ),
                                    const ProjectSpacers.spacer20(),
                                    Text(
                                      "${'publish_date'.tr} : ${feedsList[index].date ?? ""}",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const ProjectSpacers.spacer10(),
                                    FeedActionsBar(
                                      likes: feedsList[index].likes ?? 0,
                                      views: feedsList[index].views ?? 0,
                                      liked: feedsList[index].liked ?? false,
                                      showLikeButton: true,
                                      onLikeTap: () => toggleLike(index),
                                    ),
                                    const ProjectSpacers.spacer20(),
                                    SizedBox(
                                      width: Get.size.width,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Get.to(FeedsDetailView(
                                                feed: feedsList[index]));
                                          },
                                          style: ElevatedButton.styleFrom(),
                                          child: Text("view_more".tr)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                      : Center(
                          child: Text("no_diary".tr),
                        )
                  : Center(
                      child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.surface,
                    )),
            ),
          ),
        ));
  }
}
