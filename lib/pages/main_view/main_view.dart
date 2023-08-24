import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:im2alone/pages/main_view/viewmodel/main_view_model.dart';
import 'package:im2alone/product/enums/project_enums.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends MainViewModel {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      extendBody: true,
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: pages,
      ),
      bottomNavigationBar: Obx(
        () => ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          child: BottomNavigationBar(
            elevation: 1,
            currentIndex: currentIndex.value,
            onTap: (index) {
              if (index == 0) {
                fragmentController.state.value = MainStates.feeds;
              }

              tabController.animateTo(index); // TabBarView'ı güncellemek için seçilen indekse geçiş yapılır.
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.dashboard_outlined,
                ),
                label: 'all_feeds'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.menu_book_outlined,
                ),
                label: 'my_diary'.tr,
              ),
              authController.isLogin.value
                  ? BottomNavigationBarItem(
                      icon: const Icon(
                        Icons.support,
                      ),
                      label: 'my_account'.tr,
                    )
                  : BottomNavigationBarItem(
                      icon: const Icon(
                        Icons.support,
                      ),
                      label: 'login'.tr,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}