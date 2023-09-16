import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/helpers/caching_manager.dart';
import 'package:im2alone/model/user_utils/user_stats_model.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';
import 'package:im2alone/views/auth/login/login_view.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';
import '../../../product/components/buttons/profile_button.dart';
import '../../../product/config/config.dart';
import '../change_password/change_password_view.dart';
import '../edit_profile/edit_profile_view.dart';
import 'viewmodel/my_account_viewmodel.dart';
part './my_account_items.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends MyAccountViewModel with CachingManager {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'my_account'.tr,
      ),
      body: Padding(
        padding: const ProjectPaddings.all8(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() {
              return _profileHeader(
                  context,
                  authController.currentUser.value.username ?? "",
                  authController.currentUser.value.bio ?? "",
                  authController.currentUser.value.pp ?? "",
                  userStats.value);
            }),
            ProfileButtton(
              icon: const Icon(
                Icons.edit_note,
              ),
              onPressed: () {
                Get.to(() => const EditProfileView());
              },
              text: 'edit_profile'.tr,
            ),
            ProfileButtton(
              icon: const Icon(
                Icons.password,
              ),
              onPressed: () {
                Get.to(() => const ChangePasswordView());
              },
              text: 'change_password'.tr,
            ),
            ProfileButtton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => SizedBox(
                            child: AlertDialog(
                              alignment: Alignment.center,
                              contentPadding: const ProjectPaddings.horiztontal10(),
                              title: Text(
                                'change_lang'.tr,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              content: SizedBox(
                                height: 130,
                                child: Column(
                                  children: [
                                    const ProjectSpacers.spacer15(),
                                    TextButton(
                                      style: currentLang("tr"),
                                      onPressed: () {
                                        saveLocale(const Locale('tr', 'TR').toString());
                                        Get.updateLocale(const Locale('tr', 'TR'));
                                        Get.back();
                                      },
                                      child: Text(
                                        "turkish".tr,
                                        style: Theme.of(context).textTheme.headlineLarge,
                                      ),
                                    ),
                                    const ProjectSpacers.spacer15(),
                                    TextButton(
                                      style: currentLang("en"),
                                      onPressed: () {
                                        saveLocale(const Locale('en', 'US').toString());
                                        Get.updateLocale(const Locale('en', 'US'));
                                        Get.back();
                                      },
                                      child: Text("english".tr, style: Theme.of(context).textTheme.headlineLarge),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "cancel".tr,
                                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                          color: Theme.of(context).colorScheme.error,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ));
                },
                text: "change_lang".tr,
                icon: const Icon(
                  Icons.language,
                )),
            ProfileButtton(
              onPressed: () {
                Get.offAll(() => const LoginView());
                authController.logout();
              },
              text: "logout".tr,
              icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.error),
              textColor: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
