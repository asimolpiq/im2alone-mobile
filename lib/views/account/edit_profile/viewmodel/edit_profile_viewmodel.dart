import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/controller/auth_controller.dart';
import 'package:im2alone/core/helpers/request_helper.dart';
import 'package:im2alone/product/components/snackbar/custom_snacbars.dart';
import 'package:im2alone/service/user/user_service.dart';
import 'package:im2alone/views/account/edit_profile/edit_profile_view.dart';

abstract class EditProfileViewmodel extends State<EditProfileView> {
  final AuthController authController = Get.find(tag: "authmanager");
  late UserService userService;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    userService = UserService(RequestHelper().dio);
    usernameController.text = authController.currentUser.value.username ?? "";
    fullnameController.text = authController.currentUser.value.realname ?? "";
    bioController.text = authController.currentUser.value.bio ?? "";
  }

  editProfile({required String username, required String fullname, required String bio}) async {
    if (formKey.currentState!.validate()) {
      final result = await userService.editProfile(username, fullname, bio);
      if (result) {
        authController.currentUser.update((val) {
          val?.username = username;
          val?.realname = fullname;
          val?.bio = bio;
        });
        Get.back();
        Get.showSnackbar(CustomSnackbars.successSnack(message: "profile_saved".tr));
      } else {
        Get.showSnackbar(CustomSnackbars.errorSnack(error: "profile_not_saved".tr));
      }
    }
  }
}
