import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/model/auth/login_request_model.dart';
import 'package:im2alone/views/auth/login/viewmodel/login_viewmodel.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';
import 'package:im2alone/product/components/auth/login_textfield.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';
import 'package:im2alone/product/enums/project_enums.dart';
import 'package:im2alone/product/theme/colors/app_colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends LoginViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: CustomAppbar(
          title: 'login'.tr,
        ),
        body: Padding(
          padding: const ProjectPaddings.all16(),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppImages.logo.getSvg(
                  height: 300,
                  width: 500,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      LoginTextField(
                          authTextFieldType: AuthTextFieldType.username, textEditController: usernameController),
                      const ProjectSpacers.spacer20(),
                      LoginTextField(
                          authTextFieldType: AuthTextFieldType.password, textEditController: passwordController),
                      const ProjectSpacers.spacer50(),
                      _authButton("login".tr),
                      const ProjectSpacers.spacer5(),
                      Divider(
                        color: Theme.of(context).colorScheme.surface,
                        thickness: .1,
                        endIndent: Get.size.width / 16,
                        indent: Get.size.width / 16,
                      ),
                      const ProjectSpacers.spacer5(),
                      _authButton("register".tr),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Container _authButton(String text) {
    return Container(
      color: AppColors.transparent,
      width: Get.size.width,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            loginRequest(LoginRequestModel(
              username: usernameController.text.trim(),
              password: passwordController.text.trim(),
            ));
          }
        },
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.surface),
        ),
      ),
    );
  }
}
