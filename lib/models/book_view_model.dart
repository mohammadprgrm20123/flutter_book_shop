
import 'tag_view_model.dart';

class BookViewModel {
  String price;
  String bookName;
  String publisherName;
  String translator;
  double score;
  String category;
  String pages;
  String releaseDate;
  String createdAt;
  String url;
  String autherName;
  String desc;
  List<TagViewModel> tags;
  int id;
  bool isFavorite;
  bool isInCartShop;
  BookViewModel(
      {final String price,
        final String bookName,
        final String publisherName,
        final String translator,
        final double score,
        final String category,
        final String pages,
        final String releaseDate,
        final String createdAt,
        final String url,
        final String autherName,
        final String desc,
        final List<TagViewModel> tags,
        final int id});

  BookViewModel.fromJson(final Map<String, dynamic> json) {
    price = json['price'];
    bookName = json['bookName'];
    publisherName = json['publisherName'];
    translator = json['translator'];
    score = json['score'];
    score +=0.0;
    category = json['category'];
    pages = json['pages'];
    releaseDate = json['releaseDate'];
    createdAt = json['createdAt'];
    url = json['url'];
    autherName = json['autherName'];
    desc = json['desc'];
     tags = TagViewModel().tagListFromJson(json['tags']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['bookName'] = bookName;
    data['publisherName'] = publisherName;
    data['translator'] = translator;
    data['score'] = score;
    data['category'] = category;
    data['pages'] = pages;
    data['releaseDate'] = releaseDate;
    data['createdAt'] = createdAt;
    data['url'] = url;
    data['autherName'] = autherName;
    data['desc'] = desc;
    if (tags != null) {
      data['tags'] = tags.map((final v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
  List<BookViewModel> bookListFromJson(final List<dynamic> dynamicList){
    final List<BookViewModel> p = [];
    for (final element in dynamicList) {
      p.add(BookViewModel.fromJson(element));
    }
    return p;
  }
}
