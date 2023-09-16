import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/product/components/appbar/custom_appbar.dart';
import 'package:im2alone/product/components/form/form_input_decoration.dart';
import 'package:im2alone/product/components/search_items/search_profile_widget.dart';
import 'package:im2alone/product/consts/paddings/project_paddings.dart';
import 'package:im2alone/product/consts/spacers/project_spacers.dart';
import 'package:im2alone/views/search/viewmodel/search_viewmodel.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends SearchViewmodel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'search'.tr,
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const ProjectPaddings.all16(),
          child: Column(
            children: [
              TextField(
                decoration: CustomInputDecoration.searchDecoration(
                  'search_friend'.tr,
                  Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                onChanged: (value) {
                  if (value.isEmpty || value.length < 3) {
                    isSearch.value = false;
                  } else {
                    isSearch.value = true;
                    getSearchResult(value);
                  }
                },
              ),
              const ProjectSpacers.spacer15(),
              Obx(() => isSearch.value
                  ? !isLoading.value
                      ? users.isNotEmpty
                          ? ListView.builder(
                              itemCount: users.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return SearchProfileWidget(user: users[index]);
                              },
                            )
                          : Center(
                              child: Text('user_not_found'.tr),
                            )
                      : Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                  : const SizedBox.shrink())
            ],
          ),
        ),
      ),
    );
  }
}
