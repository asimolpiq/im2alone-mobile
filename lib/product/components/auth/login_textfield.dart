import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/input_borders/project_input_borders.dart';
import '../../consts/paddings/project_paddings.dart';
import '../../enums/project_enums.dart';

class LoginTextField extends StatefulWidget {
  const LoginTextField({super.key, required this.authTextFieldType, required this.textEditController});
  final TextEditingController textEditController;
  final AuthTextFieldType authTextFieldType;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.titleMedium,
      controller: widget.textEditController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        if (widget.authTextFieldType == AuthTextFieldType.username) {
          if (value.length < 3) {
            return 'Username must be at least 3 characters';
          }
        }
        if (widget.authTextFieldType == AuthTextFieldType.password) {
          if (value.length < 5) {
            return 'Password must be at least 5 characters';
          }
        }
        return null;
      },
      obscureText: AuthTextFieldType.password == widget.authTextFieldType ? !isPasswordVisible : isPasswordVisible,
      keyboardType:
          widget.authTextFieldType == AuthTextFieldType.username ? TextInputType.name : TextInputType.visiblePassword,
      decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.surface,
          filled: true,
          enabledBorder: ProjectInputBorder.authBorder(),
          border: ProjectInputBorder.authBorder(),
          hintText: widget.authTextFieldType == AuthTextFieldType.password ? "password".tr : 'username'.tr,
          hintStyle: Theme.of(context).textTheme.titleMedium,
          prefixIcon: widget.authTextFieldType == AuthTextFieldType.password
              ? Icon(
                  Icons.lock_outline,
                  color: Theme.of(context).colorScheme.background,
                )
              : Icon(
                  Icons.person_outline,
                  color: Theme.of(context).colorScheme.background,
                ),
          contentPadding: const ProjectPaddings.all16(),
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
