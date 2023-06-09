import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/details_controller.dart';

class ListTag extends GetView<DetailController> {
  @override
  Widget build(final BuildContext context) => _listTags();

  Widget _listTags() => Wrap(direction: Axis.horizontal, children: listTag());

  List<Widget> listTag() => controller.book.value!.tags!
      .map((final e) => Container(
            margin: const EdgeInsets.only(right: 8.0, bottom: 15.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                e.tag ?? '',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ))
      .toList();
}
