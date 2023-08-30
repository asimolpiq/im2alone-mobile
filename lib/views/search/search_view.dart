import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'search'.tr,
      ),
      extendBody: true,
      body: const Center(
        child: Text(
          'SearchView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
