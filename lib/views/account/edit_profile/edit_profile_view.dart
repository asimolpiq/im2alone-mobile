import 'package:easy_localization/easy_localization.dart'
    hide StringTranslateExtension;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';
import 'package:im2alone/product/components/form/form_input_decoration.dart';
import 'package:im2alone/product/config/config.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:im2alone/product/consts/radius/project_radius.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';
import 'package:im2alone/product/theme/colors/app_colors.dart';

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
                Center(
                  child: GestureDetector(
                    onTap: () => pickAvatar(),
                    child: Obx(
                      () => Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundImage:
                                authController.currentUser.value.pp != null
                                    ? NetworkImage(Config['SITE_URL'] +
                                            authController
                                                .currentUser.value.pp!)
                                        as ImageProvider<Object>?
                                    : const AssetImage('assets/empty_pp.png'),
                            child: isUploadingAvatar.value
                                ? const CircularProgressIndicator()
                                : null,
                          ),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: const Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const ProjectSpacers.spacer30(),
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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: CustomInputDecoration.profileInput("email".tr),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'email_error'.tr;
                    } else if (!value.contains("@")) {
                      return 'email_not_valid'.tr;
                    }
                    return null;
                  },
                ),
                const ProjectSpacers.spacer30(),
                DropdownButtonFormField(
                  value: genderController.text.isEmpty
                      ? null
                      : genderController.text,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.surface),
                  decoration: CustomInputDecoration.profileInput("gender".tr),
                  dropdownColor: Theme.of(context).colorScheme.secondary,
                  isExpanded: true,
                  items: genderList,
                  onChanged: (value) {
                    genderController.text = value.toString();
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'gender_error'.tr;
                    }
                    return null;
                  },
                ),
                const ProjectSpacers.spacer30(),
                TextFormField(
                  controller: birthdayController,
                  readOnly: true,
                  decoration: CustomInputDecoration.profileInput("birthday".tr),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'birthday_error'.tr;
                    }
                    return null;
                  },
                  onTap: () => showCupertinoModalPopup(
                    context: context,
                    builder: (context) => Container(
                      height: Get.size.height / 3,
                      padding: const ProjectPaddings.all20(),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: ProjectRadius.circular30(),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "done".tr,
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          Expanded(
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              initialDateTime: birthdayController.text.isEmpty
                                  ? DateTime.now()
                                  : DateFormat("dd/MM/yyyy")
                                      .parse(birthdayController.text),
                              onDateTimeChanged: (DateTime value) {
                                birthdayController.text =
                                    DateFormat("dd/MM/yyyy").format(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                          email: emailController.text.trim(),
                          gender: genderController.text,
                          birthday: birthdayController.text,
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
