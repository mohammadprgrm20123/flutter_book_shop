import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        width: 140,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xff2F4858),width: 2)
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  InkWell(
                    onTap: () {
                      onTap?.call();
                    },
                    child: _image(),
                  ),
                  _text(),
                  _addFavoriteAndCartShop(),
                ]),
              ),
            ),
          ),
        ),
      );

  Widget _addFavoriteAndCartShop() => AddFavoriteAndCartShop(
        changeValueCartShop: (final value) {
          changeValueCartShop.call(value);
        },
        changeValueFavorite: (final value) {
          changeValueFavorite.call(value);
        },
        isCartShop: bookViewModel.isInCartShop,
        isFavorite: bookViewModel.isFavorite,
      );

  Widget _text() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.yellow[800],
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              bookViewModel.bookName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 13,
              ),
              softWrap: false,
            ),
          ),
        ),
      );

  Widget _image() => ClipRRect(
        child: FadeInImage.assetNetwork(
          fadeInCurve: Curves.linearToEaseOut,
          image: bookViewModel.url,
          placeholder: 'assets/images/noImage.png',
          fit: BoxFit.cover,
          height: 140,
          width: 140,
        ),
      );
}
