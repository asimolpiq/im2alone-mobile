import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/pages/auth/login/viewmodel/login_viewmodel.dart';
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
          padding: ProjectPaddings.padding16,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppImages.logo.getSvg(
                  height: 200,
                  width: 500,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const LoginTextField(authTextFieldType: AuthTextFieldType.email),
                      const ProjectSpacers.spacer20(),
                      const LoginTextField(authTextFieldType: AuthTextFieldType.password),
                      const ProjectSpacers.spacer50(),
                      _authButton("login".tr, () {}),
                      const ProjectSpacers.spacer5(),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        thickness: .1,
                        endIndent: Get.size.width / 16,
                        indent: Get.size.width / 16,
                      ),
                      const ProjectSpacers.spacer5(),
                      _authButton("register".tr, () {}),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Container _authButton(String text, Function onPressed) {
    return Container(
      color: AppColors.transparent,
      width: Get.size.width,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            onPressed();
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
