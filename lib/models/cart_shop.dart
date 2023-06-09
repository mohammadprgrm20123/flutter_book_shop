import 'book_view_model.dart';

class CartShop {
  int? id;
  int? count;
  int? userId;
  BookViewModel? book;

  CartShop({final this.count, final this.userId, final this.book,final this.id});


  CartShop.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    userId = json['userid'];
    book = json['book'] != null ? BookViewModel.fromJson(json['book']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['count'] = count;
    data['userid'] = userId;
    if (book != null) {
      data['book'] = book!.toJson();
    }
    return data;
  }

  List<CartShop> cartShopListFromJson(final List<dynamic> dynamicList){
    final List<CartShop> cartshop = [];
    for (final element in dynamicList) {
      cartshop.add(CartShop.fromJson(element));
    }
    return cartshop;
  }

}

