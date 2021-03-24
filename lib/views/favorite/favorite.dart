import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/customwidgets/custom_widget.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:get/get.dart';

class Favorite extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: _appBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomWidget().floatingActionButton(),
      bottomNavigationBar: CustomWidget().bottomNavigationBar(),
    );

    throw UnimplementedError();
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        S.of(context).favorite,
        style:
        TextStyle(fontFamily: 'Dana', color: Colors.black, fontSize: 17.0),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }


}