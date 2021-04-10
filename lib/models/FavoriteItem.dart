import 'Book.dart';

class FavoriteItem {
  int _userId;
  Book _book;
  int _id;

  FavoriteItem({int userId, Book book, int id}) {
    this._userId = userId;
    this._book = book;
    this._id = id;
  }

  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  Book get book => _book;
  set book(Book book) => _book = book;
  int get id => _id;
  set id(int id) => _id = id;

  FavoriteItem.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this._userId;
    if (this._book != null) {
      data['book'] = this._book.toJson();
    }
    data['id'] = this._id;
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




