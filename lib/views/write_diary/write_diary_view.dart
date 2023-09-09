import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';
import 'package:im2alone/product/components/form/form_input_decoration.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:im2alone/product/consts/radius/project_radius.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';
import 'package:im2alone/views/write_diary/viewmodel/write_diary_viewmodel.dart';

class WriteDiaryView extends StatefulWidget {
  const WriteDiaryView({super.key});

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
              children: [
                TextFormField(
                  controller: contentController,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: CustomInputDecoration.textDecoration(
                    hintText: 'write_feels'.tr,
                  ),
                  maxLines: 15,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'content'.tr;
                    }
                    return null;
                  },
                ),
                const ProjectSpacers.spacer20(),
                TextFormField(
                  controller: linkController,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: CustomInputDecoration.textDecoration(
                    hintText: 'link'.tr,
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
                DropdownButtonFormField(
                  style: Theme.of(context).textTheme.bodySmall,
                  dropdownColor: Theme.of(context).colorScheme.background,
                  enableFeedback: false,
                  borderRadius: ProjectRadius.circular30(),
                  isExpanded: true,
                  decoration: CustomInputDecoration.dropdownDecoration(
                    hintText: 'privacy'.tr,
                  ),
                  items: privacyList,
                  onChanged: (value) {
                    privacyController.text = value.toString();
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'privacy_error'.tr;
                    }
                    return null;
                  },
                ),
                const ProjectSpacers.spacer20(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const ProjectPaddings.horiztontal16(),
        child: Container(
          margin: const ProjectPaddings.marginBottom20(),
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
            child: Text(
              'share'.tr.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {}
            },
          ),
        ),
      ),
    );
  }

  CustomAppbar _appbar(BuildContext context) {
    return CustomAppbar(
        title: 'write_diary'.tr,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.surface,
          ),
        ));
  }
}
