import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/controller/auth_controller.dart';
import 'package:im2alone/core/controller/fragment_controller.dart';
import 'package:im2alone/core/helpers/caching_manager.dart';
import 'package:im2alone/product/mixins/get_user_stats_mixin.dart';

import '../../../../model/user_utils/user_stats_model.dart';
import '../../../../product/components/snackbar/custom_snacbars.dart';
import '../../../../product/consts/paddings/project_paddings.dart';
import '../../../../product/consts/radius/project_radius.dart';
import '../../../../product/consts/spacers/project_spacers.dart';
import '../my_account_view.dart';

abstract class MyAccountViewModel extends State<MyAccount> with GetUserStats, CachingManager {
  final AuthController authController = Get.find(tag: "authmanager");
  final FragmentController fragmentController = Get.find(tag: "fragmentmanager");
  Rx<UserStatsModel?> userStats = UserStatsModel().obs;

  @override
  void initState() {
    super.initState();
    getMyStats();
  }

  getMyStats() async {
    final response = await getUserStats(authController.currentUser.value.id ?? "0");
    if (response.error == null) {
      userStats.value = response.userStats ?? UserStatsModel();
    } else {
      CustomSnackbars.errorSnack(error: response.error ?? "error".tr);
    }
  }

  ButtonStyle? currentLang(String code) {
    if (Get.locale!.languageCode == code) {
      return TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: ProjectRadius.circular15(),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    } else {
      return null;
    }
  }

  SizedBox changeLangDialog(BuildContext context) {
    return SizedBox(
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
    );
  }
}
