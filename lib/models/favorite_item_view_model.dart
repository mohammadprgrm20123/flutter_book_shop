import 'book_view_model.dart';


class FavoriteItem {
  int userId;
  BookViewModel book;
  int id;

  FavoriteItem(
      {final int userId,
      final BookViewModel book,
      final int id});

  FavoriteItem.fromJson(final Map<String, dynamic> json) {
    userId = json['userId'];
    book = json['book'] != null
        ? BookViewModel.fromJson(json['book'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    if (book != null) {
      data['book'] = book.toJson();
    }
    data['id'] = id;
    return data;
  }

  List<FavoriteItem> bookListFromJson(final List<dynamic> dynamicList) {
    final List<FavoriteItem> listBook = [];
    for (final element in dynamicList) {
      listBook.add(FavoriteItem.fromJson(element));
    }
    return listBook;
  }
}
