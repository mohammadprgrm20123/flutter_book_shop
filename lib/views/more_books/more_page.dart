import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/more_page_controller.dart';
import '../../custom_widgets/card_icon_favorite_icon.dart';
import '../../generated/l10n.dart';
import '../details_book/details_book.dart';

class MorePage extends GetView<MorePageController> {

  @override
  Widget build(final BuildContext context) {
    Get.lazyPut(() => MorePageController());
    return Scaffold(
        appBar: _appBar(context),
        body: Obx(() {
          if (controller.loading.value == true) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (controller.allBooks.isEmpty) {
              return Center(child: Text(S.of(Get.context!).not_exit_cases));
            }
            return GridView.builder(
              itemCount: controller.allBooks.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, childAspectRatio: 2.5),
              itemBuilder: (final context, final index) =>
                  _itemListBestBooks(index),
            );
          }
        }));
  }

  AppBar _appBar(final BuildContext context) => AppBar(
        title: _title(context),
        backgroundColor: Colors.white,
        centerTitle: true,
      );

  Text _title(final BuildContext context) => Text(
        S.of(context).more,
        style: const TextStyle(
            fontFamily: 'Dana', color: Colors.black, fontSize: 17.0),
      );

  Widget _itemListBestBooks(final int index) => Card(
        elevation: 10.0,
        child: InkWell(
          onTap: () {
            _goToDetailsPage(controller.allBooks[index].id!);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Column(
                children: [
                  ClipRRect(
                    child: FadeInImage.assetNetwork(
                      fadeInCurve: Curves.linearToEaseOut,
                      image: controller.allBooks[index].url!,
                      placeholder: 'assets/images/noImage.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  SizedBox(
                    width: 120.0,
                    child: AddFavoriteAndCartShop(
                      changeValueCartShop: (final value) {
                        if (value == true) {
                          controller.addToCartShop(
                              controller.allBooks[index]);
                          controller.allBooks[index].isInCartShop =
                              true;
                        } else {
                          controller.removeFromCartShop(
                              controller.allBooks[index]);
                          controller.allBooks[index].isInCartShop =
                              false;
                        }
                      },
                      changeValueFavorite: (final value) {
                        if (value == true) {
                          controller.addToFavorite(
                              controller.allBooks[index]);
                          controller.allBooks[index].isFavorite = true;
                        } else {
                          controller.removeFromFavorite(
                              controller.allBooks[index]);
                          controller.allBooks[index].isFavorite = false;
                        }
                      },
                      isCartShop:
                          controller.allBooks[index].isInCartShop!,
                      isFavorite: controller.allBooks[index].isFavorite!,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' نام کتاب : '
                        '${controller.allBooks[index].bookName}'),
                    Text('نام نویسنده :'
                        '${controller.allBooks[index].autherName} '
                        ' '),
                    Text('${controller.allBooks[index].price} تومان '),
                  ],
                ),
              ),
            ]),
          ),
        ),
      );

  void _goToDetailsPage(final int id) {
    Get.to(() => DetailsBook(bookId: id,))!.then((final value) {
      controller
        ..getListFavorite()
        ..getAllCartShop();
    });
  }
}
