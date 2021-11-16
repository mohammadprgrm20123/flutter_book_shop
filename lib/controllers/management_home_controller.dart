
import 'package:flutter/material.dart';
import '../views/cart_shop/cart_shop_page.dart';
import '../views/favorite/favorite.dart';
import '../views/proflie/profile.dart';
import '../views/search/search.dart';
import 'package:get/get.dart';


class ManagementHomeController extends GetxController{
  
  RxInt currentIndex = 0.obs;
  List<Widget> list =[CartShopPage(),Favorite(),Search(),Profile()];
  
}