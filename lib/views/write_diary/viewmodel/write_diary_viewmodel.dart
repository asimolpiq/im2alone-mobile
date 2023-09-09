import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../write_diary_view.dart';

abstract class WriteDiaryViewmodel extends State<WriteDiaryView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController contentController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController privacyController = TextEditingController();

  List<DropdownMenuItem<String>> privacyList = [
    DropdownMenuItem(
      value: '0',
      child: Text('only_me'.tr),
    ),
    DropdownMenuItem(
      value: '1',
      child: Text('only_friends'.tr),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('everyone'.tr),
    ),
  ];

  @override
  void dispose() {
    super.dispose();
    contentController.dispose();
    linkController.dispose();
    privacyController.dispose();
  }
}
