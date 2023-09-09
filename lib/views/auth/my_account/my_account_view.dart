import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';
import 'package:im2alone/views/auth/login/login_view.dart';
import 'package:im2alone/views/auth/my_account/viewmodel/my_account_viewmodel.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';

import '../../../product/config/config.dart';

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const ProjectSpacers.spacer30(),
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                Config['SITE_URL'] + authController.currentUser.value.pp ??
                    "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
              ),
            ),
            const ProjectSpacers.spacer20(),
            Text(
              "username: ${authController.currentUser.value.username ?? "No username"}",
              style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.surface),
            ),
            const ProjectSpacers.spacer20(),
            Text(
              "bio: ${authController.currentUser.value.bio ?? "No username"}",
              style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.surface),
            ),
            const ProjectSpacers.spacer20(),
            ElevatedButton(
                onPressed: () {
                  Get.offAll(() => const LoginView());
                  authController.logout();
                },
                child: const Text("Logout"))
          ],
        ),
      ),
    );
  }
}
