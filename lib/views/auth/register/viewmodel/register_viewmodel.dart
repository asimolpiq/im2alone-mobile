import 'package:easy_localization/easy_localization.dart' hide StringTranslateExtension;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/controller/auth_controller.dart';
import 'package:im2alone/core/helpers/caching_manager.dart';
import 'package:im2alone/core/helpers/request_helper.dart';
import 'package:im2alone/model/auth/register_model.dart';
import 'package:im2alone/model/auth/user_model.dart';
import 'package:im2alone/service/auth/auth_service.dart';
import 'package:im2alone/views/fragments/main_view/main_view.dart';

import '../../../../product/components/form/form_input_decoration.dart';
import '../../../../product/components/snackbar/custom_snacbars.dart';
import '../../../../product/consts/input_borders/project_input_borders.dart';
import '../../../../product/consts/paddings/project_paddings.dart';
import '../../../../product/consts/radius/project_radius.dart';
import '../../../../product/enums/project_enums.dart';
import '../../../../product/theme/colors/app_colors.dart';
import '../../../../product/theme/project_theme.dart';
import '../register_view.dart';

abstract class RegisterViewmodel extends State<RegisterView> with CachingManager {
  late AuthService authService;
  final AuthController authController = Get.find(tag: 'authmanager');
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
    authService = AuthService(RequestHelper().dio);
  }

  register(RegisterModel user) async {
    final response = await authService.register(user);
    if (response.error == null) {
      await saveToken(response.token ?? "").then((_) async {
        final user = await authService.getUser();
        if (user.error == null) {
          Get.showSnackbar(CustomSnackbars.successSnack(message: 'register_success'.tr));
          authController.currentUser.value = user.user ?? User();
          authController.isLogin.value = true;
          Get.off(const MainView());
        } else {
          Get.showSnackbar(CustomSnackbars.errorSnack(error: user.error!));
        }
      });
    } else {
      Get.showSnackbar(CustomSnackbars.errorSnack(error: response.error!));
    }
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
          return 'gender_error'.tr;
        }
        return null;
      },
    );
  }

  TextFormField birthdayTextField() {
    return TextFormField(
      controller: birthdayController,
      enabled: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'birthday_error'.tr;
        }
        return null;
      },
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
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'email_error'.tr;
        } else if (!value.contains("@")) {
          return 'email_not_valid'.tr;
        } else {
          return null;
        }
      },
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
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return 'real_name_error'.tr;
        }
        return null;
      },
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
        keyboardType: TextInputType.visiblePassword,
        controller: passwordController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'password_error'.tr;
          } else if (value.length < 6) {
            return 'password_short'.tr;
          }
          return null;
        },
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
      keyboardType: TextInputType.name,
      controller: usernameController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'username_error'.tr;
        } else if (value.length < 4) {
          return 'username_short'.tr;
        }
        return null;
      },
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
            register(RegisterModel(
              username: usernameController.text,
              realname: realNameController.text,
              email: emailController.text,
              birthday: birthdayController.text,
              gender: genderController.text,
              password: passwordController.text,
            ));
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
