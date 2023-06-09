import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class AddFavoriteAndCartShop extends StatefulWidget {
  Widget _iconFavorite = const Icon(
    Icons.favorite_border,
  );
  Widget _iconCartShop = const Icon(Icons.add_shopping_cart_sharp);
  bool isFavorite;
  bool isCartShop;

  AddFavoriteAndCartShop(
      {required this.changeValueCartShop,
      required this.changeValueFavorite,
      required this.isFavorite,
      required this.isCartShop}) {
    if (isCartShop == true) {
      _iconCartShop = Icon(
        Icons.add_shopping_cart_sharp,
        color: Colors.green[500],
      );
    } else {
      _iconCartShop = const Icon(Icons.add_shopping_cart_sharp);
    }

    if (isFavorite == true) {
      _iconFavorite = Icon(
        Icons.favorite,
        color: Colors.red[900],
      );
    } else {
      _iconFavorite = const Icon(
        Icons.favorite_border,
      );
    }
  }

  final ValueChanged<bool> changeValueFavorite;
  final ValueChanged<bool> changeValueCartShop;
  bool isShowLoading = false;

  @override
  State<StatefulWidget> createState() => StateFavoriteAndCartShop();
}

class StateFavoriteAndCartShop extends State<AddFavoriteAndCartShop> {
  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        iconFavorite(),
        iconCartShop(),
      ]));

  Widget iconCartShop() => InkWell(
      onTap: () {
        {
          clickOnCartShopIcon();
        }
      },
      child: widget._iconCartShop);

  void clickOnCartShopIcon() {
    if (widget.isCartShop == false) {
      widget.isCartShop = true;
      setState(() {
        widget._iconCartShop = Icon(
          Icons.add_shopping_cart_sharp,
          color: Colors.green[500],
        );
        widget.changeValueCartShop.call(true);
      });
    } else {
      widget.isCartShop = false;
      setState(() {
        widget._iconCartShop = const Icon(Icons.add_shopping_cart_sharp);
        widget.changeValueCartShop.call(false);
      });
    }
  }

  Widget iconFavorite() => InkWell(
        child: widget._iconFavorite,
        onTap: clickOnFavoriteIcon,
      );

  void clickOnFavoriteIcon() {
    if (widget.isFavorite == false) {
      widget.isFavorite = true;
      setState(() {
        widget._iconFavorite = Icon(
          Icons.favorite,
          color: Colors.red[900],
        );
        widget.changeValueFavorite.call(true);
      });
    } else {
      widget.isFavorite = false;
      setState(() {
        widget._iconFavorite = const Icon(Icons.favorite_border);
        widget.changeValueFavorite.call(false);
      });
    }
  }
}
