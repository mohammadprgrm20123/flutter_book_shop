import 'package:flutter_booki_shop/models/Book.dart';

class FavoriteItem {
  int _userId;
  Book _book;

  FavoriteItem({int id, int userId, Book book}) {
    this._userId = userId;
    this._book = book;
  }

  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  Book get book => _book;
  set book(Book book) => _book = book;

  FavoriteItem.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _book = json['book'] != null ? new Book.fromJson(json['book']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this._userId;
    if (this._book != null) {
      data['book'] = this._book.toJson();
    }
    return data;
  }

  List<FavoriteItem> BookListFromJson(List<dynamic> dynamicList){
    List<FavoriteItem> listBook = [];
    dynamicList.forEach((element) {
      listBook.add(FavoriteItem.fromJson(element));
    });
    return listBook;
  }

}
