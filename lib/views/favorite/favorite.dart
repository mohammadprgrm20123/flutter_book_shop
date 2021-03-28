import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/custom_widgets/custom_bottomNavigation.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'file:///D:/flutter_booki_shop/flutter_booki_shop/lib/views/details/details_book.dart';
import 'package:get/get.dart';

class Favorite extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: _appBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomBtnNavigation().floatingActionButton(),
      bottomNavigationBar: CustomBtnNavigation().bottomNavigationBar(),
      body: _listBooks()
    );

    throw UnimplementedError();
  }

  Container _listBooks() {
    return Container(
      child: GridView.builder(
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return _itemList();
        },
      ),
    );
  }

  GestureDetector _itemList() {
    return GestureDetector(
            onTap: (){
              Get.to(DetailsBook(1));
            },
            child: Card(
              elevation: 7.0,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),

                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(4.0),
                        child: Image.network(
                          "https://imgcdn.taaghche.com/frontCover/90938.jpg?w=700",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "کوه نور ",
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: _title(context),
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }

  Text _title(BuildContext context) {
    return Text(
      S.of(context).favorite,
      style:
      TextStyle(fontFamily: 'Dana', color: Colors.black, fontSize: 17.0),
    );
  }


}