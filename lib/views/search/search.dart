

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/customwidgets/custom_bottomNavigation.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';

class Search extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: _appBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomBtnNavigation().floatingActionButton(),
      bottomNavigationBar: CustomBtnNavigation().bottomNavigationBar(),
      body: Column(
        children: [
          //search view
          _serachView(context),
          _listBooks()
        ],
      ),
    );
  }

  Expanded _listBooks() {
    return Expanded(
          child: ListView.builder(itemBuilder: (_,int index){
            return   Container(
              height: 200.0,
              child: ListView.builder(
                itemBuilder: (BuildContext _, int index) {
                  return _itemBook();
                },
                itemCount: 20,
                scrollDirection: Axis.horizontal,
              ),
            );


            },
             itemCount: 40,
          ),
        );
  }

  Padding _itemBook() {
    return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.assetNetwork(
                      fadeInCurve: Curves.bounceIn,
                      image:
                      'https://imgcdn.taaghche.com/frontCover/90938.jpg?w=200',
                      placeholder: 'assets/images/1.jpg',
                    ),
                  ),
                );
  }

  Padding _serachView(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIconConstraints: BoxConstraints(),
                suffixIcon: IconButton(icon:Icon(Icons.delete_forever,color: Colors.red,),onPressed: (){},),
                labelText: S.of(context).search,
                hintText: S.of(context).search,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        );
  }

  AppBar _appBar() {
    return AppBar(title: _title(),
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    centerTitle: true,
    );
  }

  Text _title() {
    return Text('جستوجو',style:TextStyle(fontFamily: 'Dana', color: Colors.black, fontSize: 17.0),
  );
  }

}