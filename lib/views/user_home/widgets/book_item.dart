import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import '../../../models/book_view_model.dart';

class BookItem extends GetView<HomeController> {
  final BookViewModel bookViewModel;
  final void Function() onTap;
  final void Function(bool value)? changeValueCartShop;
  final void Function(bool value)? changeValueFavorite;

  const BookItem(
      {required this.bookViewModel,
      required this.onTap,
       this.changeValueCartShop,
       this.changeValueFavorite});

  @override
  Widget build(final BuildContext context) => item();

  Widget item() => _body();

  Widget _body() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 140,
          decoration: _boxDecoration(),
          child: InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Expanded(child: _imageClickAble()),
                _text(),
                _icons()
              ]),
            ),
          ),
        ),
      );

  Widget _icons() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            _favorite(),
            _catShop(),
          ]);

  Widget _imageClickAble() => InkWell(
        onTap: () {
          onTap.call();
        },
        child: _image(),
      );

  BoxDecoration _boxDecoration() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xff2F4858), width: 2));

  ObxValue<RxBool> _catShop() => ObxValue<RxBool>(
      (final select) => GestureDetector(
            onTap: () {
              if (select.value) {
                controller.removeItemFromCartShop(bookViewModel);
              } else {
                controller.addToCartShop(bookViewModel);
              }
              select.value = !select.value;
            },
            child: select.value
                ? const Icon(
                    Icons.add_shopping_cart,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.add_shopping_cart,
                  ),
          ),
      bookViewModel.isInCartShop!.obs);

  ObxValue<RxBool> _favorite() => ObxValue<RxBool>(
      (final select) => GestureDetector(
            onTap: () {
              if (select.value) {
                controller.removeFromFavorite(bookViewModel);
              } else {
                controller.addToFavorite(bookViewModel);
              }
              select.value = !select.value;
            },
            child: select.value
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_border_rounded,
                  ),
          ),
      bookViewModel.isFavorite!.obs);

  Widget _text() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Container(
          height: 30,
          color: Colors.orange,
          width: double.infinity,
          child: Center(
            child: _bookName(),
          ),
        ),
      );

  Widget _bookName() => Text(
        bookViewModel.bookName!,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 13,
        ),
        softWrap: false,
      );

  BoxDecoration _boxDecorationText() => BoxDecoration(
      color: Colors.yellow[800], borderRadius: BorderRadius.circular(8));

  Widget _image() => ClipRRect(
        child: FadeInImage.assetNetwork(
          fadeInCurve: Curves.linearToEaseOut,
          image: bookViewModel.url!,
          placeholder: 'assets/images/noImage.png',
          fit: BoxFit.cover,
          height: 140,
          width: 140,
        ),
      );
}
