import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/helpers/request_helper.dart';
import 'package:im2alone/model/user_utils/friend_list_response_model.dart';
import 'package:im2alone/model/user_utils/user_stats_model.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';
import 'package:im2alone/service/user/user_service.dart';
import 'package:im2alone/views/account/friend_requests/friend_request_view.dart';
import 'package:im2alone/views/account/friends_list/friends_list_view.dart';
import 'package:im2alone/views/auth/login/login_view.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';
import 'package:im2alone/product/components/notification_bell/notification_bell_button.dart';
import '../../../product/components/buttons/profile_button.dart';
import '../../../product/config/config.dart';
import '../../web_page/web_page_view.dart';
import '../blocked_users/blocked_users_view.dart';
import '../change_password/change_password_view.dart';
import '../edit_profile/edit_profile_view.dart';
import 'viewmodel/my_account_viewmodel.dart';
part './my_account_items.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends MyAccountViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'my_account'.tr,
        actions: const [NotificationBellButton()],
      ),
      body: Padding(
        padding: const ProjectPaddings.all8(),
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  return _profileHeader(
                      context,
                      authController.currentUser.value.username ?? "",
                      authController.currentUser.value.bio ?? "",
                      authController.currentUser.value.pp,
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
                          builder: (context) => changeLangDialog(context));
                    },
                    text: "change_lang".tr,
                    icon: const Icon(
                      Icons.language,
                    )),
                ProfileButtton(
                    onPressed: () => Get.to(const FriendRequestView()),
                    text: "friend_requests".tr,
                    icon: const Icon(Icons.people_alt_outlined)),
                ProfileButtton(
                    onPressed: () => Get.to(() => const BlockedUsersView()),
                    text: "blocked_users".tr,
                    icon: const Icon(Icons.block)),
                ProfileButtton(
                    onPressed: () => Get.to(() => WebPageView(
                          title: 'terms_of_service'.tr,
                          url: "${Config['SITE_URL']}terms.php",
                        )),
                    text: "terms_of_service".tr,
                    icon: const Icon(Icons.description_outlined)),
                ProfileButtton(
                    onPressed: () => Get.to(() => WebPageView(
                          title: 'support'.tr,
                          url: "${Config['SITE_URL']}support.php",
                        )),
                    text: "support".tr,
                    icon: const Icon(Icons.help_outline)),
                ProfileButtton(
                  onPressed: () {
                    Get.offAll(() => const LoginView());
                    authController.logout();
                  },
                  text: "logout".tr,
                  icon: Icon(Icons.logout,
                      color: Theme.of(context).colorScheme.error),
                  textColor: Theme.of(context).colorScheme.error,
                ),
              ],
            ),
          ),
          ConfettiWidget(
            confettiController: controllerCenter,
            blastDirection: -pi * 6, // radial value - LEFT
            emissionFrequency: 0.05,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            canvas: const Size(600, 600),
            shouldLoop:
                true, // start again as soon as the animation is finished
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
            // createParticlePath: drawStar, // define a custom shape/path.
          ),
        ]),
      ),
    );
  }
}
