import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/product/enums/project_enums.dart';

import '../../account/my_account/my_account_view.dart';
import 'viewmodel/auth_fragment_viewmodel.dart';

class AuthFragment extends StatefulWidget {
  const AuthFragment({super.key});

  @override
  State<AuthFragment> createState() => _AuthFragmentState();
}

class _AuthFragmentState extends AuthFragmentViewmodel {
  @override
  Widget build(BuildContext context) {
    return Obx(() => switch (fragmentController.authState.value) {
          AuthStates.register => const Text("Register"),
          AuthStates.forgotPassword => const Text("Forgot Password"),
          AuthStates.myAccount => const MyAccount(),
        });
  }
}
