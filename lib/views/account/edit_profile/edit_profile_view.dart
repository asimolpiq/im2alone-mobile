import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';
import 'package:im2alone/product/components/form/form_input_decoration.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';

import 'viewmodel/edit_profile_viewmodel.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends EditProfileViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "edit_profile".tr),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const ProjectPaddings.all16(),
            child: Column(
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: CustomInputDecoration.profileInput("username".tr),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'username_not_empty'.tr;
                    } else if (value.length < 3) {
                      return 'username_not_short'.tr;
                    }
                    return null;
                  },
                ),
                const ProjectSpacers.spacer30(),
                TextFormField(
                  controller: fullnameController,
                  decoration: CustomInputDecoration.profileInput("fullname".tr),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'fullname_not_empty'.tr;
                    } else if (value.length < 3) {
                      return 'fullname_not_short'.tr;
                    }
                    return null;
                  },
                ),
                const ProjectSpacers.spacer30(),
                TextFormField(
                  controller: bioController,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: CustomInputDecoration.profileInput(
                    'bio'.tr,
                  ),
                  maxLines: 15,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'bio_not_empty'.tr;
                    }
                    return null;
                  },
                ),
                const ProjectSpacers.spacer30(),
                SizedBox(
                  width: Get.size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        editProfile(
                          username: usernameController.text.trim(),
                          fullname: fullnameController.text.trim(),
                          bio: bioController.text.trim(),
                        );
                      }
                    },
                    child: Text(
                      'save'.tr.toUpperCase(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
