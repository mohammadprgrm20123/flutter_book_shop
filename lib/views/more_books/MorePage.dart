

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/more_page_controller.dart';
import 'package:flutter_booki_shop/custom_widgets/card_icon_favorite_icon.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

// ignore: must_be_immutable
class MorePage extends StatelessWidget{

  MorePageController _morePageController=Get.put(MorePageController());

  @override
  Widget build(BuildContext context) {
    _morePageController.getListFavorite();
   return  Scaffold(
      appBar: _appBar(context),
      body:
      Obx((){
        if(_morePageController.loading.value==true){
          return Center(child: CircularProgressIndicator());
        }
        else{
          if(_morePageController.allBooks.length==0){
            return Center(child: Text(S.of(Get.context).not_exit_cases));
          }
          return GridView.builder(
            itemCount: _morePageController.allBooks.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,childAspectRatio: 2.5),
            itemBuilder: (BuildContext context, int index) {
              return _itemListBestBooks(index);
            },
          );
        }
      })
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
      S.of(context).more,
      style:
      TextStyle(fontFamily: 'Dana', color: Colors.black, fontSize: 17.0),
    );
  }
  Widget _itemListBestBooks(int index) {
    return Obx((){
      return Card(
        elevation: 10.0,
        child: InkWell(
          onTap: () {
            // _goToDetailsPage(_homeController.listBestBook[index].id);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        child: FadeInImage.assetNetwork(
                          fadeInCurve: Curves.linearToEaseOut,
                          image: '${_morePageController.allBooks[index].url}',
                          placeholder: 'assets/images/noImage.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
                      SizedBox(
                        width: 120.0,
                        child: AddFavortieAndCartShop(
                          changeValueCartShop: (value){
                              if(value==true){
                                _morePageController.addToCartShop(_morePageController.allBooks[index]);
                                _morePageController.allBooks[index].isInCartShop=true;
                              }
                              else{
                                _morePageController.removeFromCartShop(_morePageController.allBooks[index]);
                                _morePageController.allBooks[index].isInCartShop=false;
                              }
                          },
                          changeValueFavorite: (value){
                            if(value==true){
                              _morePageController.addToFavorite(_morePageController.allBooks[index]);
                              _morePageController.allBooks[index].isFavorite=true;
                            }
                            else{
                              _morePageController.removeFromFavorite(_morePageController.allBooks[index]);
                              _morePageController.allBooks[index].isFavorite=false;
                            }
                          },
                          isCartShop: _morePageController.allBooks[index].isInCartShop,
                          isFavorite: _morePageController.allBooks[index].isFavorite,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(" نام کتاب : ${_morePageController.allBooks[index].bookName}"),
                        Text("نام نویسنده :${_morePageController.allBooks[index].authorName}  "),
                        Text("${_morePageController.allBooks[index].price} تومان "),
                      ],
                    ),
                  ),

                ]
            ),
          ),
        ),
      );
    });
  }
}