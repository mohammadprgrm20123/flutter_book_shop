import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/cart_shop.dart';
import 'package:flutter_booki_shop/models/purches_view_model.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../shareprefrence.dart';

class CartShopController extends GetxController {
  AppRepository _appRepository;
  final RxBool _loading = false.obs;
  final RxBool _loadingCalculate = false.obs;
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

  void getShoppingCartList() {
    _loading(true);
    _appRepository.getShoppingListCart().then((final value) {
      _loading(false);
      _listCartShop = value;
      calculateTotalPrice();
    }).onError((final error, final stackTrace) {
      _loading(false);
    });
  }

  List<CartShop> get listCartShop => _listCartShop;

  double calculateTotalPrice() {
    if (_listCartShop != null) {
      for (final element in _listCartShop) {
        totalPrice += double.parse(element.book.price);
      }
    } else {
      return 0.0;
    }
    return totalPrice.value;
  }

  void increasePrice(final CartShop cartShop) {
    totalPrice.value = totalPrice.value + (double.parse(cartShop.book.price));
  }

  void reducePrice(final CartShop cartShop, final int count) {
    if (count == 0) {
      totalPrice.value = totalPrice.value - (double.parse(cartShop.book.price));
    } else {
      totalPrice.value = totalPrice.value - (double.parse(cartShop.book.price));
    }
  }

  void registerUserPurchase(final double price) {
    if (price == 0) {
      Get.snackbar(
          S.of(Get.context).error, S.of(Get.context).count_of_cart_shops_zero);
    } else {
      MySharePrefrence().getId().then((final userId) {
        final Purchase purches = Purchase()
          ..userId = userId
          ..cartShop = listCartShop;
        final Gregorian gNow = Gregorian.now();
        purches.date = gNow.toString();
        _appRepository.registerUserPurchase(purches);
      });
    }
  }

  void removeItemOfShoppingCart(final CartShop cartShop) {
    _appRepository.removeItemOfShoppingCart(cartShop);
  }

  void reduceListPrice(final CartShop cartShop, final int count) {
    totalPrice.value =
        totalPrice.value - (count * double.parse(cartShop.book.price));
  }
}
