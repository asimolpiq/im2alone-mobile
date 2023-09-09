import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:im2alone/product/consts/radius/project_radius.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';
import 'package:im2alone/views/my_diary/viewmodel/my_diary_viewmodel.dart';
import 'package:native_webview/native_webview.dart';

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
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const ProjectPaddings.all8(),
            child: Obx(
              () => !isLoading.value
                  ? ListView.builder(
                      physics: const ClampingScrollPhysics(),
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
                                    color: Theme.of(context).colorScheme.surface,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const ProjectSpacers.spacer10(),
                                Offstage(offstage: isCompleted, child: const CircularProgressIndicator()),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  height: isCompleted ? Get.size.height * 0.09 : 0,
                                  child: ClipRRect(
                                    borderRadius: ProjectRadius.circular15(),
                                    child: WebView(
                                      initialUrl: feedsList[index].link ?? "",
                                      onProgressChanged: (_, p1) {
                                        if (p1 == 100) {
                                          setState(() {
                                            isCompleted = true;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const ProjectSpacers.spacer20(),
                                Text(
                                  "${'publish_date'.tr} : ${feedsList[index].date ?? ""}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const ProjectSpacers.spacer20(),
                                SizedBox(
                                  width: Get.size.width,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(FeedsDetailView(feed: feedsList[index]));
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
                      child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.surface,
                    )),
            ),
          ),
        ));
  }
}
