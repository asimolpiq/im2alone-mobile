import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';

class MyDiaryView extends StatefulWidget {
  const MyDiaryView({super.key});

  @override
  State<MyDiaryView> createState() => _MyDiaryViewState();
}

class _MyDiaryViewState extends State<MyDiaryView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'my_diary'.tr,
        ),
        body: const Center(
          child: Text(
            'MyDiaryView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
