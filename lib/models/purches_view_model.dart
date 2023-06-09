import 'cart_shop.dart';

class Purchase {
  int? id;
  int? userId;
  String? date;
  List<CartShop>? cartShop;

  Purchase({
    this.id,
    this.userId,
    this.date,
    this.cartShop,
  });

  Purchase.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];

    if (json['cartShop'] != null) {
      cartShop = CartShop().cartShopListFromJson(json['cartShop']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['date'] = date;
    if (cartShop != null) {
      data['cartShop'] = cartShop!.map((final v) => v.toJson()).toList();
    }
    return data;
  }

  List<Purchase> purchaseListFromJson(final List<dynamic> dynamicList) {
    final List<Purchase> p = [];
    for (final element in dynamicList) {
      p.add(Purchase.fromJson(element));
    }
    return p;
  }
}
