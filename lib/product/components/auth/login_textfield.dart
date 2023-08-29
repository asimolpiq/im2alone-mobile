import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/input_borders/project_input_borders.dart';
import '../../consts/paddings/project_paddings.dart';
import '../../enums/project_enums.dart';

class LoginTextField extends StatefulWidget {
  const LoginTextField({super.key, required this.authTextFieldType});
  final AuthTextFieldType authTextFieldType;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: AuthTextFieldType.password == widget.authTextFieldType ? isPasswordVisible : false,
      keyboardType: widget.authTextFieldType == AuthTextFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.visiblePassword,
      decoration: InputDecoration(
          border: ProjectInputBorder.authBorder(),
          hintText: widget.authTextFieldType == AuthTextFieldType.password ? "password".tr : 'email'.tr,
          hintStyle: Theme.of(context).textTheme.titleMedium,
          prefixIcon: widget.authTextFieldType == AuthTextFieldType.password
              ? const Icon(Icons.lock_outline)
              : const Icon(Icons.email),
          contentPadding: ProjectPaddings.padding16,
          focusedBorder: ProjectInputBorder.authBorder(),
          suffixIcon: widget.authTextFieldType == AuthTextFieldType.password
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: isPasswordVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                )
              : null),
    );
  }
}
