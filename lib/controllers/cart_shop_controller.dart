

import 'package:flutter_booki_shop/models/CartShop.dart';
import 'package:flutter_booki_shop/repository/AppRepository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CartShopController extends GetxController{

  AppRepository _appRepository;
  RxBool _loading = false.obs;
  RxBool _loadingCalcute = false.obs;
  List<CartShop> _listCartShop;

  RxBool get loadingCalcute => _loadingCalcute;

  RxBool get loading => _loading;
  RxDouble totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository();
    getCartShopList();
  }




  getCartShopList(){

    _loading(true);
    _appRepository.getAllItemsOfCartShops().then((value) {
      _loading(false);
      _listCartShop = value;
      calcuteTotalPrice();
    }).onError((error, stackTrace) {
      _loading(false);
    });
  }

  List<CartShop> get listCartShop => _listCartShop;



  double calcuteTotalPrice(){

    if(_listCartShop!=null){
      _listCartShop.forEach((element) {
        totalPrice +=double.parse(element.book.price);
      });
    }
    else
      {
        return 0.0;
      }

    return totalPrice.value;
  }

  increaSePrice(CartShop cartShop,int count){
    totalPrice.value = totalPrice.value+(count*double.parse(cartShop.book.price));
  }

  decresePrice(CartShop cartShop,int count){
    print(count.toString()+"======");
    if(count==0){
      totalPrice.value = totalPrice.value-double.parse(cartShop.book.price);
    }else{
      totalPrice.value = totalPrice.value-(count*double.parse(cartShop.book.price));

    }
  }

}