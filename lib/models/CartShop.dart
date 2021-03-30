import 'package:flutter_booki_shop/models/Book.dart';

class CartShop {
  int _count;
  int _userId;
  Book _book;

  CartShop({int count, int userid, Book book}) {
    this._count = count;
    this._userId = userid;
    this._book = book;
  }

  int get count => _count;
  set count(int count) => _count = count;
  int get userid => _userId;
  set userid(int userid) => _userId = userid;
  Book get book => _book;
  set book(Book book) => _book = book;

  CartShop.fromJson(Map<String, dynamic> json) {
    _count = json['count'];
    _userId = json['userid'];
    _book = json['book'] != null ? new Book.fromJson(json['book']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this._count;
    data['userid'] = this._userId;
    if (this._book != null) {
      data['book'] = this._book.toJson();
    }
    return data;
  }

  List<CartShop> CartShopListFromJson(List<dynamic> dynamicList){
    List<CartShop> cartshop = [];
    dynamicList.forEach((element) {
      cartshop.add(CartShop.fromJson(element));
    });
    return cartshop;
  }

}

