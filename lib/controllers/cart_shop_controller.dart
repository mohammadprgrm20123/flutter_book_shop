
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/CartShop.dart';
import 'package:flutter_booki_shop/models/purches.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../shareprefrence.dart';

class CartShopController extends GetxController{

  AppRepository _appRepository;
  RxBool _loading = false.obs;
  RxBool _loadingCalculate = false.obs;
  List<CartShop> _listCartShop;

  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository();
    getShoppingCartList();
  }

  RxBool get loadingCalculate => _loadingCalculate;
  RxBool get loading => _loading;
  RxDouble totalPrice = 0.0.obs;

  getShoppingCartList() {
    _loading(true);
    _appRepository.getShoppingListCart().then((value) {
      _loading(false);
      _listCartShop = value;
      calculateTotalPrice();
    }).onError((error, stackTrace) {
      _loading(false);
    });
  }

  List<CartShop> get listCartShop => _listCartShop;

  double calculateTotalPrice(){
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

  increasePrice(CartShop cartShop){
    totalPrice.value = totalPrice.value+(double.parse(cartShop.book.price));
  }

  reducePrice(CartShop cartShop,int count){
    if(count==0){
      totalPrice.value = totalPrice.value-(double.parse(cartShop.book.price));
    }else{
      totalPrice.value = totalPrice.value-(double.parse(cartShop.book.price));

    }
  }

  registerUserPurchase(double price){
    if(price==0){
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).count_of_cart_shops_zero);
    }
    else{
      MySharePrefrence().getId().then((userId) {
        Purchase purches=new Purchase();
        purches.userId =userId;
        Gregorian gNow = Gregorian.now();
        purches.date =gNow.toString();
        purches.cartShop = listCartShop;
        _appRepository.registerUserPurchase(purches);
      });
    }
  }


  removeItemOfShoppingCart(CartShop cartShop){
    _appRepository.removeItemOfShoppingCart(cartShop);
  }

  void reduceListPrice(CartShop cartShop, int count) {
    totalPrice.value = totalPrice.value-((count)*double.parse(cartShop.book.price));

  }


}