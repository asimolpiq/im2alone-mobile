import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';
import 'package:im2alone/product/components/form/form_input_decoration.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:im2alone/product/consts/radius/project_radius.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';
import 'package:im2alone/product/theme/colors/app_colors.dart';
import 'package:im2alone/views/diary_pages/write_diary/viewmodel/write_diary_viewmodel.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class WriteDiaryView extends StatefulWidget {
  final Function? callback;
  const WriteDiaryView({super.key, this.callback});

  @override
  State<WriteDiaryView> createState() => _WriteDiaryViewState();
}

class _WriteDiaryViewState extends WriteDiaryViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar(context),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const ProjectPaddings.all16(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'write_feels'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: AppColors.white),
                  ),
                  const ProjectSpacers.spacer10(),
                  ClipRRect(
                    borderRadius: ProjectRadius.circular15(),
                    child: ToolBar(
                      controller: contentController,
                      toolBarColor: AppColors.secondary,
                      iconColor: AppColors.white,
                      activeIconColor: Theme.of(context).colorScheme.primary,
                      padding: const ProjectPaddings.all8(),
                      toolBarConfig: const [
                        ToolBarStyle.bold,
                        ToolBarStyle.italic,
                        ToolBarStyle.underline,
                        ToolBarStyle.listOrdered,
                        ToolBarStyle.listBullet,
                        ToolBarStyle.image,
                        ToolBarStyle.clean,
                      ],
                    ),
                  ),
                  const ProjectSpacers.spacer10(),
                  ClipRRect(
                    borderRadius: ProjectRadius.circular15(),
                    child: QuillHtmlEditor(
                      controller: contentController,
                      minHeight: 220,
                      backgroundColor: AppColors.secondary,
                      padding: const ProjectPaddings.all16(),
                      hintText: 'write_feels'.tr,
                      hintTextStyle: const TextStyle(color: AppColors.white),
                      textStyle: const TextStyle(color: AppColors.white),
                    ),
                  ),
                  if (contentError)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 4),
                      child: Text(
                        'content'.tr,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12),
                      ),
                    ),
                  const ProjectSpacers.spacer20(),
                  Text(
                    '${'link'.tr}:',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
                  ),
                  const ProjectSpacers.spacer5(),
                  TextFormField(
                    controller: linkController,
                    style: const TextStyle(color: AppColors.white, fontSize: 16),
                    decoration: CustomInputDecoration.plainDecoration(
                      'link_hint'.tr,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'link'.tr;
                      } else if (!value.contains("spotify")) {
                        return 'link_error'.tr;
                      }
                      return null;
                    },
                  ),
                  const ProjectSpacers.spacer20(),
                  Text(
                    '${'privacy'.tr}:',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
                  ),
                  const ProjectSpacers.spacer5(),
                  FormField<String>(
                    validator: (value) {
                      if (privacyController.text.isEmpty) {
                        return 'privacy_error'.tr;
                      }
                      return null;
                    },
                    builder: (field) {
                      final selectedIndex = privacyController.text.isEmpty
                          ? -1
                          : int.tryParse(privacyController.text) ?? -1;
                      return InkWell(
                        borderRadius: ProjectRadius.circular8(),
                        onTap: () async {
                          final selected = await showModalBottomSheet<int>(
                            context: context,
                            backgroundColor: AppColors.secondary,
                            shape: const RoundedRectangleBorder(
                              borderRadius: ProjectRadius.onlyTop30(),
                            ),
                            builder: (context) => SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  privacyKeys.length,
                                  (index) => ListTile(
                                    title: Text(
                                      privacyKeys[index].tr,
                                      style: const TextStyle(color: AppColors.white),
                                    ),
                                    onTap: () => Navigator.pop(context, index),
                                  ),
                                ),
                              ),
                            ),
                          );
                          if (selected != null) {
                            setState(() {
                              privacyController.text = selected.toString();
                            });
                            field.didChange(selected.toString());
                          }
                        },
                        child: InputDecorator(
                          isEmpty: selectedIndex < 0,
                          decoration: CustomInputDecoration.plainDecoration(
                            'privacy'.tr,
                          ).copyWith(
                            errorText: field.errorText,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: selectedIndex >= 0
                                    ? Text(
                                        privacyKeys[selectedIndex].tr,
                                        style: const TextStyle(
                                            color: AppColors.white, fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              const Icon(Icons.arrow_drop_down,
                                  color: AppColors.white, size: 20),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const ProjectSpacers.spacer20(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Obx(() {
          return Padding(
            padding: const ProjectPaddings.horiztontal16(),
            child: Container(
              margin: const ProjectPaddings.marginBottom20(),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: !isLoading.value ? onSubmitPressed : null,
                child: Text(
                  'share'.tr.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          );
        }));
  }

  CustomAppbar _appbar(BuildContext context) {
    return CustomAppbar(
      title: 'write_diary'.tr,
    );
  }
}
