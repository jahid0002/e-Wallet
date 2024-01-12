import 'package:class20/all_page/nav_bar/nav_controller.dart';
import 'package:class20/const/all_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});
  final controller = Get.put(NavController());
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: GetBuilder<NavController>(builder: (conrler) {
        return controller.sceren[controller.currentIndex.value];
      },),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10, top: 8),
        child: GetBuilder<NavController>(builder: (controllr) {
          return SalomonBottomBar( 
             selectedItemColor: AllColors.secendaryColors, 
             unselectedItemColor: AllColors.textBlackColor.withOpacity(.6),
              currentIndex: controller.currentIndex.value,
              onTap: (value) {
                controller.changeIndex(value);
              },
              items: [
                SalomonBottomBarItem(
                  icon: const Icon(Icons.home_outlined),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.person_search_outlined),
                  title: const Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.file_open_outlined),
                  title: const Text(
                    'File',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.settings_outlined),
                  title: const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ]);
        }),
      ),
    );
  }
}
