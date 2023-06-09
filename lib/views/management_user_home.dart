import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_shop_controller.dart';
import '../controllers/favorite_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/management_home_controller.dart';
import '../controllers/profile_controller.dart';
import 'user_home/user_home.dart';

class ManagementUserHome extends StatelessWidget {
  final controller = Get.put(ManagementHomeController());

  @override
  Widget build(final BuildContext context) => Obx(() => Scaffold(
        body: controller.currentIndex.value == 4
            ? UserHomePage()
            : controller.list[controller.currentIndex.value],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            resetControllers();
            controller.currentIndex.value = 4;
          },
          child: const Icon(Icons.home_outlined,color: Colors.white,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: bottomNavigationBar(),
      ));

  Widget bottomNavigationBar() => Obx(() => AnimatedBottomNavigationBar(
      splashColor: Colors.red,
      activeIndex: controller.currentIndex.value,
      icons: const [
        Icons.shopping_bag_outlined,
        Icons.favorite_border,
        Icons.search,
        Icons.account_circle_outlined,
      ],
      elevation: 10.0,
      backgroundColor: Colors.yellow[800],
      gapLocation: GapLocation.center,
      leftCornerRadius: 10,
      rightCornerRadius: 10,
      notchSmoothness: NotchSmoothness.smoothEdge,
      splashRadius: 50.0,
      onTap: (final index) {
        switch (index) {
          case 0:
            {
              resetControllers();
              controller.currentIndex.value = 0;
            }
            break;

          case 1:
            {
              resetControllers();
              controller.currentIndex.value = 1;
            }
            break;

          case 2:
            {
              resetControllers();
              controller.currentIndex.value = 2;
            }
            break;

          case 3:
            {
              resetControllers();
              controller.currentIndex.value = 3;
            }
            break;
        }
      }));



  void resetControllers(){
    Get.delete<HomeController>(force: true);
    Get.delete<CartShopController>(force: true);
    Get.delete<FavoriteController>(force: true);
    Get.delete<SearchController>(force: true);
    Get.delete<ProfileController>(force: true);
  }
}
