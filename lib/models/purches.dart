import 'CartShop.dart';

class Purchase {
  int id;
  int userId;
  String date;
  List<CartShop> cartShop;

  Purchase({this.id, this.userId, this.date, this.cartShop});

  Purchase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    if (json['cartShop'] != null) {
      cartShop = new List<CartShop>();
      json['cartShop'].forEach((v) {
        cartShop.add(new CartShop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['date'] = this.date;
    if (this.cartShop != null) {
      data['cartShop'] = this.cartShop.map((v) => v.toJson()).toList();
    }
    return data;
  }
  List<Purchase> purchesListFromJson(List<dynamic> dynamicList){
    List<Purchase> p = [];
    dynamicList.forEach((element) {
      p.add(Purchase.fromJson(element));
    });
    return p;
  }
}