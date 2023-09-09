import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:im2alone/model/feeds/feeds_model.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:native_webview/native_webview.dart';

import '../../product/components/appbar/custom_appbar.dart';
import '../../product/consts/radius/project_radius.dart';
import '../../product/consts/spacers/project_spacers.dart';
import 'viewmodel/feeds_detail_viewmodel.dart';

class FeedsDetailView extends StatefulWidget {
  final FeedsModel feed;
  const FeedsDetailView({super.key, required this.feed});

  @override
  State<FeedsDetailView> createState() => _FeedsDetailViewState();
}

class _FeedsDetailViewState extends FeedsDetailViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: widget.feed.date ?? "",
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const ProjectPaddings.all16(),
          child: Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.secondary,
            child: Padding(
              padding: const ProjectPaddings.all16(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HtmlWidget(
                    widget.feed.content ?? "",
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
                        initialUrl: widget.feed.link ?? "",
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
                    "${'publish_date'.tr} : ${widget.feed.date ?? ""}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (authController.currentUser.value.id == widget.feed.userId)
                    Column(
                      children: [
                        const ProjectSpacers.spacer20(),
                        SizedBox(
                          width: Get.size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              deleteThisDiary(widget.feed.id ?? "");
                            },
                            child: Text("delete".tr),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
