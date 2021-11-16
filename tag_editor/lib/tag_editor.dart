library adder_cart_shop;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagEditor extends StatefulWidget {
  const TagEditor(
      {final this.addTags,
      final this.removeTags,
      final this.firstValueListTag});

  final ValueChanged<String> addTags;
  final ValueChanged<String> removeTags;
  final List<String> firstValueListTag;

  @override
  State<StatefulWidget> createState() => StateTagEditor(firstValueListTag);
}

class StateTagEditor extends State<TagEditor> {
  String tagCtr;
  List<String> listTag = [];

  StateTagEditor(final List<String> listFirst) {
    if (listFirst == null) {
      listTag = [];
    } else {
      listTag
        ..clear()
        ..addAll(listFirst);
    }
  }

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (final tag) {
                          tagCtr = tag;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'تگ',
                          hintText: 'تگ',
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (tagCtr != null) {
                        listTag.add(tagCtr);
                        widget.addTags.call(tagCtr);
                        setState(() {});
                      }
                    },
                    child: const Icon(Icons.add)),
              )
            ],
          ),
          Wrap(
            direction: Axis.horizontal,
            spacing: 5.0,
            runSpacing: 10.0,
            children: listWidgetTag(),
          ),
        ],
      );

  List<Widget> listWidgetTag() => listTag
      .map((final String e) => Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(e),
                GestureDetector(
                    onTap: () {
                      listTag.remove(e);
                      widget.removeTags.call(e);
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.remove_circle_sharp,
                      color: Colors.white,
                    ))
              ],
            ),
          ))
      .toList();
}
