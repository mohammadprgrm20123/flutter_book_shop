import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/card_icon_favorite_icon.dart';
import '../../../models/book_view_model.dart';

class BookItem extends StatelessWidget {
  final BookViewModel bookViewModel;
  final void Function() onTap;
  final void Function(bool value) changeValueCartShop;
  final void Function(bool value) changeValueFavorite;

  const BookItem(
      {final Key key,
      final this.bookViewModel,
      final this.onTap,
      final this.changeValueCartShop,
      final this.changeValueFavorite})
      : super(key: key);

  @override
  Widget build(final BuildContext context) => item();

  Widget item() => Container(
        width: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                color: Colors.white,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  InkWell(
                    onTap: () {
                      onTap?.call();
                      //_goToDetailsPage(_homeController.listPopularBook[index].id);
                    },
                    child: ClipRRect(
                      child: FadeInImage.assetNetwork(
                        fadeInCurve: Curves.linearToEaseOut,
                        image: '${bookViewModel.url}',
                        placeholder: 'assets/images/noImage.png',
                        height: 200,
                        width: 150,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      bookViewModel.bookName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                  Obx(() => AddFavoriteAndCartShop(
                        changeValueCartShop: (final value) {
                          changeValueCartShop.call(value);
                          /*if (value == true) {
                        _homeController.addToCartShop(
                            _homeController.listPopularBook[index]);
                        _homeController.listPopularBook[index].isInCartShop =
                        true;
                        _homeController.countCartShop.value++;
                      } else {
                        _homeController.removeItemFromCartShop(
                            _homeController.listPopularBook[index]);
                        _homeController.listPopularBook[index].isInCartShop =
                        false;
                        _homeController.countCartShop.value--;
                      }*/
                        },
                        changeValueFavorite: (final value) {
                          changeValueFavorite.call(value);
                          /*if (value == true) {
                        _homeController.addToFavorite(
                            _homeController.listPopularBook[index]);
                        _homeController.listPopularBook[index].isFavorite =
                        true;
                      } else {
                        _homeController.removeFromFavorite(
                            _homeController.listPopularBook[index]);
                        _homeController.listPopularBook[index].isFavorite =
                        false;
                      }*/
                        },
                        isCartShop: bookViewModel.isInCartShop,
                        isFavorite: bookViewModel.isFavorite,
                      ))
                ]),
              ),
            ),
          ),
        ),
      );
}
