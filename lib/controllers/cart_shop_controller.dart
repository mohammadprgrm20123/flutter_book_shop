import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../generated/l10n.dart';
import '../models/cart_shop.dart';
import '../models/purches_view_model.dart';
import '../repository/app_repository.dart';
import '../server/api_client.dart';
import '../shareprefrence.dart';

class CartShopController extends GetxController {
  final AppRepository _appRepository = AppRepository(ApiClient());
  final RxBool _loading = false.obs;
  final RxBool _loadingCalculate = false.obs;
  RxList<CartShop> listCartShop = <CartShop>[].obs;

  @override
  void onInit() {
    super.onInit();
    getShoppingCartList();
  }

  RxBool get loadingCalculate => _loadingCalculate;

  RxBool get loading => _loading;
  RxDouble totalPrice = 0.0.obs;

  void getShoppingCartList() {
    _loading(true);
    _appRepository.getShoppingListCart().then((final value) {
      _loading(false);
      listCartShop.value = value;
    }).onError((final error, final stackTrace) {
      _loading(false);
    });
  }

  double calculateTotalPrice() {
    totalPrice.value = 0;
    if (listCartShop.isNotEmpty) {
      for (final element in listCartShop) {
        totalPrice.value += double.parse(element.book!.price! * element.count!);
      }
    } else {
      return 0.0;
    }
    return totalPrice.value;
  }

  void increasePrice(final CartShop cartShop) {
    totalPrice.value = totalPrice.value + (double.parse(cartShop.book!.price!));
  }

  void reducePrice(final CartShop cartShop, final int count) {
    if (count == 0) {
      totalPrice.value =
          totalPrice.value - (double.parse(cartShop.book!.price!));
    } else {
      totalPrice.value =
          totalPrice.value - (double.parse(cartShop.book!.price!));
    }
  }

  void registerUserPurchase(final double price) {
    if (price == 0) {
      Get.snackbar(S.of(Get.context!).error,
          S.of(Get.context!).count_of_cart_shops_zero);
    } else {
      MyStorage().getId().then((final userId) {
        final Purchase purches = Purchase()
          ..userId = userId
          ..cartShop = listCartShop.value;
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
        totalPrice.value - (count * double.parse(cartShop.book!.price!));
  }
}
