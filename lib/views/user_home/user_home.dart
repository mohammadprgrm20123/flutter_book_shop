import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../custom_widgets/card_icon_favorite_icon.dart';
import '../../custom_widgets/custom_bottom_navigation.dart';
import '../../custom_widgets/horisental_card_pager.dart';
import '../../generated/l10n.dart';
import '../cart_shop/cart_shop_page.dart';
import '../details_book/details_book.dart';
import '../favorite/favorite.dart';
import '../more_books/more_page.dart';
import '../proflie/profile.dart';
import '../search/search.dart';
import 'widgets/book_item.dart';

class UserHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateUserHome();
}

class StateUserHome extends State<UserHome> {
  final homeController = Get.put(HomeController());
  @override
  Widget build(final BuildContext context) => Scaffold(
      body: _scrollView(context),
      floatingActionButton: CustomBtnNavigation().floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomNavigationBar(),
    );

  Widget _scrollView(final BuildContext context) => SafeArea(
        child: Column(
          children: [
            backGround(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: [
                  _theBestBooksList(context),
                  _theMostPopularBooksList(context),
                  _audioBooksList(context),
                ],
              ),
            ),
          ],
        ),
      );

  Container _audioBooksList(final BuildContext context) => Container(
        decoration: _backgroundBoxDecoration(),
        child: Column(
          children: [
            _titleOfList(context, S.of(context).audio_books),
            _listAudioBooks(),
          ],
        ),
      );

  BoxDecoration _backgroundBoxDecoration() => const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white38,
            Colors.black12,
          ],
        ),
      );

  Text _textMore(final BuildContext context) => Text(S.of(context).more);

  Expanded _textTitleList(final BuildContext context, final String popular) =>
      Expanded(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(popular),
      ));

  Widget _listAudioBooks() => Obx(() {
        if (homeController.loading.value == true) {
          return const CircularProgressIndicator();
        } else {
          return _itemListAudioBooks();
        }
      });

  Padding _itemListAudioBooks() => Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: HorizontalCardPager(
          initialPage: homeController.itemsAudioBook.length ~/ 2,
          onPageChanged: (final page) => {},
          onSelectedItem: (final page) {
            _goToDetailsPage(homeController.listAudioBook[page].id);
          },
          items: homeController.itemsAudioBook,
        ),
      );

  Padding _iconArrow() => const Padding(
        padding: EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: null,
          icon: Icon(Icons.arrow_forward_ios),
        ),
      );

  Container _theBestBooksList(final BuildContext context) =>
      _bestBooks(context);

  Container _theMostPopularBooksList(final BuildContext context) => Container(
        decoration: _backgroundBoxDecoration(),
        child: Column(
          children: [
            _titleOfList(context, S.of(context).popular),
            _listPopularBooks()
          ],
        ),
      );

  Widget _titleOfList(final BuildContext context, final String text) =>
      GestureDetector(
        onTap: () {
          Get.to(() => MorePage()).then((final value) {
            homeController
              ..getFavoriteList()
              ..getNumberOfShoppingCart();
          });
        },
        child: Row(
          children: [
            _textTitleList(context, text),
            _textMore(context),
            _iconArrow()
          ],
        ),
      );

  Widget _listPopularBooks() => Obx(() {
        if (homeController.loading.value == true) {
          return const CircularProgressIndicator();
        } else {
          return Container(
            height: 280.0,
            child: ListView.builder(
              itemBuilder: (final _, final index) => BookItem(
                bookViewModel: homeController.listPopularBook[index],
              ),
              itemCount: homeController.listPopularBook.length,
              scrollDirection: Axis.horizontal,
            ),
          );
        }
      });

  Container _bestBooks(final BuildContext context) => Container(
        decoration: _backgroundBoxDecoration(),
        child: Column(
          children: [
            _titleOfList(context, S.of(context).the_best),
            _listBestBooks()
          ],
        ),
      );

  Widget _listBestBooks() => Obx(
        () {
          if (homeController.loading.value == true) {
            return const CircularProgressIndicator();
          } else {
            return Container(
              height: 250,
              child: ListView.builder(
                itemBuilder: (final _, final index) =>
                    _itemListBestBooks(index),
                itemCount: homeController.listBestBook.length,
                scrollDirection: Axis.horizontal,
              ),
            );
          }
        },
      );

  Widget _itemListBestBooks(final int index) => Container(
      height: 200,
      width: 150,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            _goToDetailsPage(homeController.listBestBook[index].id);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              color: Colors.white,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                ClipRRect(
                  child: FadeInImage.assetNetwork(
                    fadeInCurve: Curves.linearToEaseOut,
                    image: homeController.listBestBook[index].url,
                    placeholder: 'assets/images/noImage.png',
                    fit: BoxFit.fitWidth,
                    height: 150,
                    width: 150,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.yellow[900],
                        borderRadius: BorderRadius.circular(3)),
                    child: Column(
                      children: [
                        Text(
                          homeController.listBestBook[index].bookName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => AddFavoriteAndCartShop(
                    changeValueCartShop: (final value) {
                      if (value == true) {
                        homeController
                            .addToCartShop(homeController.listBestBook[index]);
                        homeController.listBestBook[index].isInCartShop = true;
                        homeController.countCartShop.value++;
                      } else {
                        homeController.removeItemFromCartShop(
                            homeController.listBestBook[index]);
                        homeController.listBestBook[index].isInCartShop = false;
                        homeController.countCartShop.value--;
                      }
                    },
                    changeValueFavorite: (final value) {
                      if (value == true) {
                        homeController
                            .addToFavorite(homeController.listBestBook[index]);
                        homeController.listBestBook[index].isFavorite = true;
                      } else {
                        homeController.removeFromFavorite(
                            homeController.listBestBook[index]);
                        homeController.listBestBook[index].isFavorite = false;
                      }
                    },
                    isCartShop: homeController.listBestBook[index].isInCartShop,
                    isFavorite: homeController.listBestBook[index].isFavorite,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ));

  Widget _badgeShop() => InkWell(
        onTap: () {
          Get.to(() => CartShopPage()).then((final value) {
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

  AnimatedBottomNavigationBar bottomNavigationBar() =>
      AnimatedBottomNavigationBar(
          activeIndex: null,
          icons: const [
            Icons.shopping_bag_outlined,
            Icons.favorite_border,
            Icons.search,
            Icons.account_circle_outlined,
          ],
          elevation: 20.0,
          backgroundColor: Colors.white,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          splashRadius: 10.0,
          activeColor: Colors.blue,
          onTap: (final index) {
            switch (index) {
              case 0:
                {
                  Get.to(() => CartShopPage()).then((final value) {
                    homeController.getFavoriteList();
                  });
                }
                break;

              case 1:
                {
                  Get.to(() => Favorite()).then((final value) {
                    homeController.getFavoriteList();
                  });
                }
                break;

              case 2:
                {
                  Get.to(() => Search());
                }
                break;

              case 3:
                {
                  Get.to(() => Profile());
                }
                break;
            }
          });

  void _goToDetailsPage(final id) {
    Get.to(() => DetailsBook(id)).then((final value) {
      homeController
        ..getNumberOfShoppingCart()
        ..getFavoriteList();
    });
  }

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
}
