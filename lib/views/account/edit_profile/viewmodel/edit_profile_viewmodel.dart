import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isUploadingAvatar = false.obs;

  List<DropdownMenuItem<String>> get genderList => [
        DropdownMenuItem(value: '0', child: Text('male'.tr)),
        DropdownMenuItem(value: '1', child: Text('female'.tr)),
        DropdownMenuItem(value: '2', child: Text('unisex'.tr)),
      ];

  @override
  void initState() {
    super.initState();
    userService = UserService(RequestHelper().dio);
    usernameController.text = authController.currentUser.value.username ?? "";
    fullnameController.text = authController.currentUser.value.realname ?? "";
    bioController.text = authController.currentUser.value.bio ?? "";
    emailController.text = authController.currentUser.value.email ?? "";
    genderController.text = authController.currentUser.value.gender ?? "";
    birthdayController.text = authController.currentUser.value.birthday ?? "";
  }

  pickAvatar() async {
    final picked =
        await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked == null) return;
    isUploadingAvatar.value = true;
    final newPp = await userService.uploadAvatar(picked.path);
    isUploadingAvatar.value = false;
    if (newPp != null) {
      authController.currentUser.update((val) {
        val?.pp = newPp;
      });
      Get.showSnackbar(CustomSnackbars.successSnack(message: "avatar_saved".tr));
    } else {
      Get.showSnackbar(CustomSnackbars.errorSnack(error: "avatar_not_saved".tr));
    }
  }

  editProfile({
    required String username,
    required String fullname,
    required String bio,
    required String email,
    required String gender,
    required String birthday,
  }) async {
    if (formKey.currentState!.validate()) {
      final result = await userService.editProfile(
          username, fullname, bio, email, gender, birthday);
      if (result) {
        authController.currentUser.update((val) {
          val?.username = username;
          val?.realname = fullname;
          val?.bio = bio;
          val?.email = email;
          val?.gender = gender;
          val?.birthday = birthday;
        });
        Get.back();
        Get.showSnackbar(CustomSnackbars.successSnack(message: "profile_saved".tr));
      } else {
        Get.showSnackbar(CustomSnackbars.errorSnack(error: "profile_not_saved".tr));
      }
    }
  }
}
