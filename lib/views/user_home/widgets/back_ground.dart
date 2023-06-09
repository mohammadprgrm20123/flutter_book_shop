import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_booki_shop/views/cart_shop/cart_shop_page.dart';

class BackGround extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  @override
  Widget build(final BuildContext context) => backGround();

  Widget backGround() => Container(
      decoration: BoxDecoration(color: Colors.yellow[800]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'کتاب فروشی انلاین',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        _badgeShop()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              height: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(150),
                ),
                color: Colors.white,
              ))
        ],
      ));

  Widget _badgeShop() => InkWell(
    onTap: () {
      Get.to(() => CartShopPage())!.then((final value) {
        homeController.getFavoriteList();
      });
    },
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        _iconShop(),
        _circleBadge(),
      ],
    ),
  );
  Widget _circleBadge() => Positioned(
      left: 20.0,
      bottom: 20.0,
      child: Container(
          height: 20.0,
          width: 20.0,
          decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
          child: Center(
              child: Obx(() => Text(
                '${homeController.countCartShop.value}',
                style: const TextStyle(color: Colors.white),
              )))));

  Icon _iconShop() => const Icon(
    Icons.shopping_cart_outlined,
    color: Colors.black,
    size: 30.0,
  );
}
