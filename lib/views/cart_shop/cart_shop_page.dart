import 'package:adder_cart_shop/custom_adder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/cart_shop_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/CartShop.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CartShopPage extends StatelessWidget {
  CartShopController _cartShopController = Get.put(CartShopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            if (_cartShopController.loading.value == true) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (_cartShopController.listCartShop.length == 0) {
                return _textNotExist();
              } else {
                return _listCartShop();
              }
            }
          }),
          _calcutePrice()
        ],
      )
      ,
    );
  }

  Widget _textNotExist() {
    return Expanded(
      child: Center(
                  child: Text(S.of(Get.context).not_exit_cases),
                ),
    );
  }

  Container  _calcutePrice() {
    return Container(
      child: Card(
        elevation: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _btnContinue(),
            _totalPrice()
          ],
        ),
        color: Colors.blue[100],
      ),
      height: 80.0,

    );
  }

  Padding _btnContinue() {
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){
              _cartShopController.purchaseRequest(_cartShopController.totalPrice.value);
            }, child: Text(S.of(Get.context).continue1)),
          );
  }

  Expanded _totalPrice() {
    return Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:Obx((){
              if(_cartShopController.loading.value==false){
             return Text("${_cartShopController.totalPrice.round()} ${S.of(Get.context).toman} ",textAlign: TextAlign.end,style: TextStyle(fontSize: 18.0));
            }
              else{
                return CircularProgressIndicator();
              }
            }
          )));
  }

  Expanded _listCartShop() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (_, int index) {
          return _listItem(_cartShopController.listCartShop[index],index);
        },
        itemCount: _cartShopController.listCartShop.length,
      ),
    );
  }

  Widget _listItem(CartShop cartShop,int index) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: _card(cartShop, index),
    );
  }

  Card _card(CartShop cartShop, int index) {
    return Card(
      elevation: 8.0,
      child: Container(
        height: 180.0,
        child: Row(
          children: [_imageAndCustomAdder(cartShop,index), _nameAndPrice(cartShop), _btnDelete(cartShop)],
        ),
      ),
    );
  }

  Widget _btnDelete(CartShop cartShop) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(onPressed: (){
          _removeItemLIst(cartShop);
        }, icon: Icon(Icons.delete), label: Text(S.of(Get.context).delete))
      ],
    );
  }

  void _removeItemLIst(CartShop cartShop) {
     _cartShopController.loading(true);
     _cartShopController.listCartShop.remove(cartShop);
     if(cartShop.count!=0){
       _cartShopController.decreseListPrice(cartShop,cartShop.count);
     }
    _cartShopController.loading(false);
     requestForDelete(cartShop);
  }

  Widget _nameAndPrice(CartShop cartShop) {
    return Expanded(
      child: Container(
        height: 180.0,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${cartShop.book.bookName}"),
                Text("${S.of(Get.context).price} : ${cartShop.book.price}"),
                Text("${S.of(Get.context).author_name}  : ${cartShop.book.authorName.substring(0,8)}..."),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _imageAndCustomAdder(CartShop cartShop,int index) {
    return Column(
      children: [
        _imageBook(cartShop),
        _customAdder(cartShop, index),
      ],
    );
  }

  Padding _customAdder(CartShop cartShop, int index) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: CustomAdder(
          value: cartShop.count,
          backgroundColor: Colors.red,
          textColor: Colors.black,
          onChangedAdd: (count) {
            _cartShopController.listCartShop[index].count=count;
            _cartShopController.increasePrice(cartShop);
          },
            onChangedRemove: (count){
              _cartShopController.decresePrice(cartShop, count);
              _cartShopController.listCartShop[index].count=count;
              if(count==0){
                _cartShopController.listCartShop.remove(cartShop);
                _removeItemLIst(cartShop);
              }
            }

          ,
        ),
      );
  }

  FadeInImage _imageBook(CartShop cartShop) {
    return FadeInImage.assetNetwork(
        fadeInCurve: Curves.linearToEaseOut,
        image: cartShop.book.url,
        placeholder: "",
        height: 120.0,
        width: 80.0,
      );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: _title(context),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  Text _title(BuildContext context) {
    return Text(S.of(Get.context).cart_shop,
        style: TextStyle(
            fontFamily: S.of(Get.context).name_font_dana, color: Colors.black, fontSize: 17.0));
  }

  void requestForDelete(CartShop cartShop) {
    _cartShopController.requestForDeleteCartShopItem(cartShop);
  }
}