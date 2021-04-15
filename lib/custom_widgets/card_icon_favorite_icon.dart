import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class AddFavoriteAndCartShop extends StatefulWidget {
  Widget _iconFavorite = Icon(
    Icons.favorite_border,
  );
  Widget _iconCartShop = Icon(Icons.add_shopping_cart_sharp);
  bool isFavorite;
  bool isCartShop;

  AddFavoriteAndCartShop(
      {this.changeValueCartShop,
      this.changeValueFavorite,
      this.isFavorite,
      this.isCartShop}) {
    if (this.isCartShop == true) {
      _iconCartShop = Icon(
        Icons.add_shopping_cart_sharp,
        color: Colors.green[500],
      );
    } else {
      _iconCartShop = Icon(Icons.add_shopping_cart_sharp);
    }

    if (this.isFavorite == true) {
      _iconFavorite = Icon(
        Icons.favorite,
        color: Colors.red[900],
      );
    } else {
      _iconFavorite = Icon(
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
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
               iconFavorite(),
               iconCartShop(),
        ]));
  }

  InkWell iconCartShop() {
    return InkWell(
            onTap: () {
              {
                clickOnCartShopIcon();
              }
            },
            child: widget._iconCartShop);
  }

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
        widget._iconCartShop =
            Icon(Icons.add_shopping_cart_sharp);
        widget.changeValueCartShop.call(false);
      });
    }
  }

  InkWell iconFavorite() {
    return InkWell(
          child: widget._iconFavorite,
          onTap: () {
            clickOnFavoriteIcon();
          },
        );
  }

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
        widget._iconFavorite = Icon(Icons.favorite_border);
        widget.changeValueFavorite.call(false);
      });
    }
  }
}
