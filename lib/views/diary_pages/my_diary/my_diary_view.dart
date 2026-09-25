import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';
import 'package:im2alone/product/components/feed_actions/feed_actions_bar.dart';
import 'package:im2alone/product/components/notification_bell/notification_bell_button.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:im2alone/product/consts/radius/project_radius.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';
import 'package:im2alone/views/diary_pages/my_diary/viewmodel/my_diary_viewmodel.dart';
import 'package:im2alone/views/diary_pages/write_diary/write_diary_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../feeds_detail/feeds_detail_view.dart';

class MyDiaryView extends StatefulWidget {
  const MyDiaryView({super.key});

  @override
  State<MyDiaryView> createState() => _MyDiaryViewState();
}

class _MyDiaryViewState extends MyDiaryViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          title: 'my_diary'.tr,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(WriteDiaryView(
                    callback: () => getMyDiary(),
                  ));
                },
                icon: Icon(
                  Icons.post_add_outlined,
                  size: Get.size.width * 0.09,
                  color: Theme.of(context).colorScheme.primary,
                )),
            const NotificationBellButton(),
          ],
        ),
        body: Padding(
          padding: const ProjectPaddings.all8(),
          child: RefreshIndicator(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            color: Theme.of(context).colorScheme.primary,
            onRefresh: () async {
              await getMyDiary();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Obx(() => pendingDiaries.isEmpty
                      ? const SizedBox.shrink()
                      : Column(
                          children: pendingDiaries
                              .map((pending) => Card(
                                    elevation: 0,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withValues(alpha: 0.6),
                                    child: Padding(
                                      padding: const ProjectPaddings.all16(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.cloud_upload_outlined,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  size: 18),
                                              const ProjectSpacers.spacer5(),
                                              Text(
                                                'pending_diary_badge'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                              ),
                                            ],
                                          ),
                                          const ProjectSpacers.spacer5(),
                                          HtmlWidget(
                                            pending.content ?? "",
                                            textStyle: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        )),
                  Obx(
                    () => !isLoading.value
                        ? feedsList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: feedsList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 0,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    child: Padding(
                                      padding: const ProjectPaddings.all16(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          HtmlWidget(
                                            feedsList[index].content ?? "",
                                            customStylesBuilder: (element) {
                                              if (element.outerHtml
                                                  .contains('<p>')) {
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
                                              offstage:
                                                  isWebViewCompleted(index),
                                              child:
                                                  const CircularProgressIndicator()),
                                          AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            height: isWebViewCompleted(index)
                                                ? Get.size.height * 0.086
                                                : 0,
                                            child: ClipRRect(
                                              borderRadius:
                                                  ProjectRadius.circular15(),
                                              child: (feedsList[index].link ??
                                                          "")
                                                      .isEmpty
                                                  ? const SizedBox.shrink()
                                                  : WebViewWidget(
                                                      controller:
                                                          webViewControllerFor(
                                                        index,
                                                        feedsList[index].link ??
                                                            "",
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          const ProjectSpacers.spacer20(),
                                          Text(
                                            "${'publish_date'.tr} : ${feedsList[index].date ?? ""}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          const ProjectSpacers.spacer10(),
                                          FeedActionsBar(
                                            likes: feedsList[index].likes ?? 0,
                                            views: feedsList[index].views ?? 0,
                                            liked: feedsList[index].liked ?? false,
                                            showLikeButton: false,
                                          ),
                                          const ProjectSpacers.spacer20(),
                                          SizedBox(
                                            width: Get.size.width,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Get.to(FeedsDetailView(
                                                    feed: feedsList[index],
                                                    callback: () =>
                                                        getMyDiary(),
                                                  ));
                                                },
                                                style:
                                                    ElevatedButton.styleFrom(),
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
                ],
              ),
            ),
          ),
        ));
  }
}
