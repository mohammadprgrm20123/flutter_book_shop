import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class CardItem {
  Widget buildWidget(final double diffPosition);
}

class ImageCardItem extends CardItem {
  final Widget image;
  final int id;

  ImageCardItem({required this.image,required this.id, });

  @override
  Widget buildWidget(final double diffPosition) => image;
}

class IconTitleCardItem extends CardItem {
  final IconData iconData;
  final String text;
  final Color selectedBgColor;
  final Color noSelectedBgColor;
  final Color selectedIconTextColor;
  final Color noSelectedIconTextColor;

  IconTitleCardItem({
    required this.iconData,
    required this.text,
    this.selectedIconTextColor = Colors.white,
    this.noSelectedIconTextColor = Colors.grey,
    this.selectedBgColor = Colors.blue,
    this.noSelectedBgColor = Colors.white,
  });

  @override
  Widget buildWidget(final double diffPosition) {
    double iconOnlyOpacity = 1.0;
    double iconTextOpacity = 0;

    if (diffPosition < 1) {
      iconOnlyOpacity = diffPosition;
      iconTextOpacity = 1 - diffPosition;
    } else {
      iconOnlyOpacity = 1.0;
      iconTextOpacity = 0;
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: iconTextOpacity,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 6)
                ],
                color: selectedBgColor,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Icon(
                      iconData,
                      color: selectedIconTextColor,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    text,
                    style:
                        TextStyle(fontSize: 15, color: selectedIconTextColor),
                  ),
                )
              ],
            ),
          ),
        ),
        Opacity(
          opacity: iconOnlyOpacity,
          child: Container(
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 6),
                ],
                color: noSelectedBgColor,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            padding: const EdgeInsets.all(10),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Icon(
                iconData,
                color: noSelectedIconTextColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
