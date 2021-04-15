library adder_cart_shop;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagEditor extends StatefulWidget {

  TagEditor({this.addTags,this.removeTags,this.firstValueListTag});
  final ValueChanged<String> addTags;
  final ValueChanged<String> removeTags;
   List<String> firstValueListTag=[];

   int state=0;




  @override
  State<StatefulWidget> createState() {
    if(state==0)
      {
        state++;
        return StateTagEditor(firstValueListTag);
      }

  }

}

class StateTagEditor extends State<TagEditor> {
  String tagCtr;
  List<String> listTag=[];

  StateTagEditor(List<String> listFirst){
    if(listFirst==null){
      this.listTag=[];
    }
    else{
      this.listTag.clear();
      this.listTag.addAll(listFirst);
    }
  }

  @override
  Widget build(BuildContext context) {

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
                    widget.removeTags.call(e);
                    setState(() {});
                  },
                  child: Icon(Icons.remove_circle_sharp,color: Colors.white,))
            ],
          ),
        );
      }).toList();
    }




}
