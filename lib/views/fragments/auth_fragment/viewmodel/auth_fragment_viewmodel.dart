import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/controller/fragment_controller.dart';

import '../auth_fragment.dart';

abstract class AuthFragmentViewmodel extends State<AuthFragment> {
  FragmentController fragmentController = Get.find(tag: "fragmentmanager");
  @override
  void initState() {
    super.initState();
  }
}
