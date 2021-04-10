import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddFavortieAndCartShop extends StatefulWidget {
  Widget _iconFavorite = Icon(
    Icons.favorite_border,
  );
  Widget _iconCartShop = Icon(Icons.add_shopping_cart_sharp);
  bool isFavorite;
  bool isCartShop;

  AddFavortieAndCartShop(
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
  State<StatefulWidget> createState() => StateFavortieAndCartShop();
}

class StateFavortieAndCartShop extends State<AddFavortieAndCartShop> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(
            child: widget._iconFavorite,
            onTap: () {
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
            },
          ),
          InkWell(
              onTap: () {
                {
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
              },
              child: widget._iconCartShop),
        ]));
  }
}
