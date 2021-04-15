library adder_cart_shop;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagEditor extends StatefulWidget {

  TagEditor({this.addTags,this.removeTags,this.firstValueListTag});
  final ValueChanged<String> addTags;
  final ValueChanged<String> removeTags;
   List<String> firstValueListTag=[];

  @override
  State<StatefulWidget> createState() {
    print("State<StatefulWidget>");
    return StateTagEditor(listTag: firstValueListTag);
  }
}

class StateTagEditor extends State<TagEditor> {
  String tagCtr;
  List<String> listTag=[];

  StateTagEditor({this.listTag}){
    if(listTag==null){
      this.listTag=[];
    }
  }

  @override
  Widget build(BuildContext context) {
    print(listTag.length.toString());

    return Container(
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(

                      keyboardType: TextInputType.text,
                      onChanged: (tag) {
                        tagCtr=tag;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "تگ",
                        hintText: "تگ",
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: ElevatedButton(onPressed: (){
                if(tagCtr.isNotEmpty){
                  print(tagCtr);
                  widget.addTags.call(tagCtr);
                  listTag.add(tagCtr);
                  setState(() {
                  });
                }}, child: Icon(Icons.add)),
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
    ));
  }

  List<Widget> listWidgetTag() {

      return listTag.map((String e) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.blue),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${e.toString()}"),
              GestureDetector(
                  onTap: () {
                    listTag.remove(e);
                    widget.removeTags.call(tagCtr);
                    setState(() {});
                  },
                  child: Icon(Icons.remove_circle_sharp,color: Colors.white,))
            ],
          ),
        );
      }).toList();
    }




}
