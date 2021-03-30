

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartShopPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(
     appBar: _appBar(context),

      body: SingleChildScrollView(
        child: ListView.builder(itemBuilder:(_,int index){

          return Text("sd");

        },
        itemCount: 20,

        ),
      ),

    );
    throw UnimplementedError();
  }
  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: _titile(context),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  Text _titile(BuildContext context) {
    return Text("سبد خرید",
        style: TextStyle(
            fontFamily: 'Dana', color: Colors.black, fontSize: 17.0));
  }
}