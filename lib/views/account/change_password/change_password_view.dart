import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../product/components/appbar/custom_appbar.dart';
import '../../../product/components/form/form_input_decoration.dart';
import '../../../product/consts/paddings/project_paddings.dart';
import '../../../product/consts/spacers/project_spacers.dart';
import '../../../product/enums/project_enums.dart';
import 'viewmodel/change_password_viewmodel.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ChangePasswordViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "change_password".tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppImages.logo.getSvg(
              height: 240,
              width: 200,
              color: Theme.of(context).primaryColor.withOpacity(.85),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const ProjectPaddings.all16(),
                child: Column(
                  children: [
                    TextFormField(
                      controller: passwordController,
                      decoration: CustomInputDecoration.profileInput("new_password".tr),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password_not_empty'.tr;
                        } else if (value.length < 6) {
                          return 'password_not_short'.tr;
                        }
                        return null;
                      },
                    ),
                    const ProjectSpacers.spacer30(),
                    TextFormField(
                      controller: confirmPasswordController,
                      decoration: CustomInputDecoration.profileInput("confirm_password".tr),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password_not_empty'.tr;
                        } else if (value != passwordController.text) {
                          return 'password_not_match'.tr;
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
                            changePassword(
                              password: passwordController.text.trim(),
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
          ],
        ),
      ),
    );
  }
}
