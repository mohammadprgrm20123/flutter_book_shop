import 'package:adder_cart_shop/custom_adder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/cart_shop_controller.dart';
import 'package:flutter_booki_shop/models/CartShop.dart';
import 'package:get/get.dart';

class CartShopPage extends StatelessWidget {
  CartShopController _cartShopController = Get.put(CartShopController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            print(_cartShopController.loading.value.toString()+"Scaffoldlist");
            if (_cartShopController.loading.value == true) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (_cartShopController.listCartShop.length == 0) {
                return Center(
                  child: Text("موردی وجود ندارد"),
                );
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
    throw UnimplementedError();
  }

  Container  _calcutePrice() {
    return Container(
      child: Card(
        elevation: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){
                _cartShopController.purchesRequest(_cartShopController.totalPrice.value);
              }, child: Text("ادامه فرایند")),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:Obx((){
                print(_cartShopController.loading.value.toString()+"_calcutePrice");
                if(_cartShopController.loading.value==false){
               return Text("${_cartShopController.totalPrice} تومان ",textAlign: TextAlign.end,style: TextStyle(fontSize: 18.0));
              }
                else{
                  return CircularProgressIndicator();
                }
              }
            )))
          ],
        ),
        color: Colors.blue[100],
      ),
      height: 80.0,

    );
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
      child: Card(
        elevation: 8.0,
        child: Container(
          height: 180.0,
          child: Row(
            children: [_imagAndCutomAdder(cartShop,index), _nameAndPrice(cartShop), _btnDelete(cartShop)],
          ),
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
        }, icon: Icon(Icons.delete), label: Text("حذف"))
      ],
    );
  }

  void _removeItemLIst(CartShop cartShop) {
     _cartShopController.loading(true);
     _cartShopController.listCartShop.remove(cartShop);
     if(cartShop.count!=0){
       _cartShopController.decresePrice(cartShop,cartShop.count);
     }
    _cartShopController.loading(false);
     requedtForDelete(cartShop);
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
                Text("قیمت : ${cartShop.book.price}"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _imagAndCutomAdder(CartShop cartShop,int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            //Get.to(()=>DetailsBook(_homeController.listPopularBook[index].id));
          },
          child: FadeInImage.assetNetwork(
            fadeInCurve: Curves.linearToEaseOut,
            image: cartShop.book.url,
            placeholder: "",
            height: 120.0,
            width: 80.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: CustomAdder(
            value: cartShop.count,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            onChangedAdd: (count) {
              _cartShopController.listCartShop[index].count=count;
              _cartShopController.increaSePrice(cartShop, count);
            },
              onChangedRemove: (count){
                _cartShopController.decresePrice(cartShop, count);
                _cartShopController.listCartShop[index].count=count;
              }

            ,
          ),
        ),
      ],
    );
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

  void requedtForDelete(CartShop cartShop) {
    _cartShopController.requestForDeletecartSHopItem(cartShop);
  }
}