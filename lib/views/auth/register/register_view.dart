import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';

import 'viewmodel/register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends RegisterViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "register".tr),
      body: Padding(
        padding: const ProjectPaddings.all16(),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  appLogo(),
                  const ProjectSpacers.spacer30(),
                  usernameTextField(),
                  const ProjectSpacers.spacer15(),
                  passwordTextField(),
                  const ProjectSpacers.spacer15(),
                  realnameTextField(),
                  const ProjectSpacers.spacer15(),
                  emailTextField(),
                  const ProjectSpacers.spacer15(),
                  birthdayTextField(),
                  const ProjectSpacers.spacer15(),
                  genderDropDown(),
                  const ProjectSpacers.spacer20(),
                  registerButton("register".tr),
                ],
              ),
            )),
      ),
    );
  }
}
