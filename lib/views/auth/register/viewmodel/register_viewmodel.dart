import 'package:easy_localization/easy_localization.dart' hide StringTranslateExtension;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../product/components/form/form_input_decoration.dart';
import '../../../../product/components/snackbar/custom_snacbars.dart';
import '../../../../product/consts/input_borders/project_input_borders.dart';
import '../../../../product/consts/paddings/project_paddings.dart';
import '../../../../product/consts/radius/project_radius.dart';
import '../../../../product/enums/project_enums.dart';
import '../../../../product/theme/colors/app_colors.dart';
import '../../../../product/theme/project_theme.dart';
import '../register_view.dart';

abstract class RegisterViewmodel extends State<RegisterView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController genderController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController realNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  bool showPassword = false;

  List<DropdownMenuItem<String>> privacyList = [
    DropdownMenuItem(
      value: '0',
      child: Text('male'.tr),
    ),
    DropdownMenuItem(
      value: '1',
      child: Text('female'.tr),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('unisex'.tr),
    ),
  ];
  @override
  void initState() {
    super.initState();
  }

  DropdownButtonFormField<String> genderDropDown() {
    return DropdownButtonFormField(
      value: genderController.text.isEmpty ? null : genderController.text,
      style: Theme.of(context).textTheme.headlineMedium,
      dropdownColor: Theme.of(context).colorScheme.secondary,
      enableFeedback: true,
      borderRadius: ProjectRadius.circular30(),
      isExpanded: true,
      decoration: CustomInputDecoration.registerDecoration(
        'gender'.tr,
        Icon(Icons.transgender, color: Theme.of(context).colorScheme.surface),
      ),
      items: privacyList,
      onChanged: (value) {
        genderController.text = value.toString();
      },
      validator: (value) {
        if (value == null) {
          return 'privacy_error'.tr;
        }
        return null;
      },
    );
  }

  TextFormField birthdayTextField() {
    return TextFormField(
      controller: birthdayController,
      enabled: true,
      style: Theme.of(context).textTheme.headlineMedium,
      onTap: () => showCupertinoModalPopup(
          context: context,
          builder: (context) => Padding(
                padding: const ProjectPaddings.all20(),
                child: Container(
                  height: Get.size.height / 3,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: ProjectRadius.circular30(),
                  ),
                  child: Padding(
                    padding: const ProjectPaddings.all8(),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () => Navigator.pop(this.context),
                                child: Text(
                                  "done".tr,
                                  style: const TextStyle(color: Colors.blue),
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            initialDateTime: birthdayController.text.isEmpty
                                ? DateTime.now()
                                : DateFormat("dd/MM/yyyy").parse(birthdayController.text),
                            onDateTimeChanged: (DateTime value) {
                              birthdayController.text = DateFormat("dd/MM/yyyy").format(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
      decoration: CustomInputDecoration.registerDecoration(
          "birthday".tr,
          Icon(
            Icons.cake_outlined,
            color: Theme.of(context).colorScheme.surface,
          )),
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      controller: emailController,
      style: Theme.of(context).textTheme.headlineMedium,
      decoration: CustomInputDecoration.registerDecoration(
          "email".tr,
          Icon(
            Icons.email_outlined,
            color: Theme.of(context).colorScheme.surface,
          )),
    );
  }

  TextFormField realnameTextField() {
    return TextFormField(
      controller: realNameController,
      style: Theme.of(context).textTheme.headlineMedium,
      decoration: CustomInputDecoration.registerDecoration(
          "real_name".tr,
          Icon(
            Icons.person_pin_circle_outlined,
            color: Theme.of(context).colorScheme.surface,
          )),
    );
  }

  TextFormField passwordTextField() {
    return TextFormField(
        controller: passwordController,
        style: Theme.of(context).textTheme.headlineMedium,
        obscureText: !showPassword,
        decoration: InputDecoration(
          fillColor: AppColors.secondary,
          filled: true,
          prefixIcon: Icon(
            Icons.password_outlined,
            color: Theme.of(context).colorScheme.surface,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            icon: Icon(
              showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          enabledBorder: ProjectInputBorder.authBorder(),
          border: ProjectInputBorder.authBorder(),
          hintText: "password".tr,
          hintStyle: ProjectTheme.createTheme().textTheme.titleMedium?.copyWith(color: AppColors.white, fontSize: 18),
          contentPadding: const ProjectPaddings.all16(),
          focusedBorder: ProjectInputBorder.primaryBorder(),
        ));
  }

  TextFormField usernameTextField() {
    return TextFormField(
      controller: usernameController,
      style: Theme.of(context).textTheme.headlineMedium,
      decoration: CustomInputDecoration.registerDecoration(
          "username".tr,
          Icon(
            Icons.person,
            color: Theme.of(context).colorScheme.surface,
          )),
    );
  }

  SizedBox appLogo() {
    return SizedBox(
      height: Get.size.height / 6,
      width: Get.size.width / 1.5,
      child: AppImages.logo.getSvg(
        fit: BoxFit.cover,
      ),
    );
  }

  Container registerButton(String text) {
    return Container(
      color: AppColors.transparent,
      width: Get.size.width,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            Get.showSnackbar(CustomSnackbars.successSnack(message: 'register_success'.tr));
          }
        },
        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Theme.of(context).colorScheme.surface),
        ),
      ),
    );
  }
}
