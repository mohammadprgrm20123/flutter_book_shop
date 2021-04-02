library adder_cart_shop;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class CustomAdder extends StatefulWidget {
  Color backgroundColor = Colors.blue;
  Color textColor = Colors.black;
  int value = 0;

  @override
  State<StatefulWidget> createState() {
    return StateAdder();
  }

  CustomAdder({this.value, this.textColor, this.backgroundColor,this.onChangedAdd,this.onChangedRemove});

  final ValueChanged<int> onChangedAdd;
  final ValueChanged<int> onChangedRemove;
}

void onChanged() => {};

class StateAdder extends State<CustomAdder> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Container(

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      increment();
                    });
                  },
                  child: SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  )),
            ),
            SizedBox(
              width: 50.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${widget.value}',textAlign:TextAlign.center,style: TextStyle(fontSize: 22.0),maxLines: 1,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    decrement();
                  });
                },
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircleAvatar(
                    child: Icon(
                      Icons.remove,
                    ),

                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void increment() {
    widget.value++;
    widget.onChangedAdd?.call(widget.value);
  }

  void decrement() {
    if(widget.value!=0)
     {
       widget.value--;
       widget.onChangedRemove?.call(widget.value);
     }


  }
}
