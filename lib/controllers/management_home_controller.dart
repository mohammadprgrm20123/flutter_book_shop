import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/cart_shop/cart_shop_page.dart';
import '../views/favorite/favorite.dart';
import '../views/proflie/profile.dart';
import '../views/search/search.dart';
import '../views/user_home/user_home.dart';

class ManagementHomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  List<Widget> list = [
    UserHomePage(),
    CartShopPage(),
    Favorite(),
    Search(),
    Profile()
  ];
}
