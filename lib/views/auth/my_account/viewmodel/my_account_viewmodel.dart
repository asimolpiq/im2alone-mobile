import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/core/controller/auth_controller.dart';
import 'package:im2alone/core/controller/fragment_controller.dart';
import 'package:im2alone/views/auth/my_account/my_account_view.dart';

abstract class MyAccountViewModel extends State<MyAccount> {
  final AuthController authController = Get.find(tag: "authmanager");
  final FragmentController fragmentController = Get.find(tag: "fragmentmanager");
  @override
  void initState() {
    super.initState();
  }
}
