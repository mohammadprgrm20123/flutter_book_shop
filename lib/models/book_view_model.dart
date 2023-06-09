import 'tag_view_model.dart';

class BookViewModel {
  String? price;
  String? bookName;
  String? publisherName;
  String? translator;
  num? score;
  String? category;
  String? pages;
  String? releaseDate;
  String? createdAt;
  String? url;
  String? autherName;
  String? desc;
  List<TagViewModel>? tags;
  int? id;
  bool? isFavorite;
  bool? isInCartShop;

  BookViewModel({
    this.price,
    this.bookName,
    this.publisherName,
    this.translator,
    this.score,
    this.category,
    this.pages,
    this.releaseDate,
    this.createdAt,
    this.url,
    this.autherName,
    this.desc,
    this.tags,
    this.id,
    this.isFavorite = false,
    this.isInCartShop = false,
  });

  BookViewModel.fromJson(final Map<String, dynamic> json) {
    price = json['price'];
    bookName = json['bookName'];
    publisherName = json['publisherName'];
    translator = json['translator'];
    score = json['score'];
    category = json['category'];
    pages = json['pages'];
    releaseDate = json['releaseDate'];
    createdAt = json['createdAt'];
    url = json['url'];
    autherName = json['autherName'];
    desc = json['desc'];
    tags = TagViewModel().tagListFromJson(json['tags']);
    id = json['id'];
    isFavorite = false;
    isInCartShop = false;
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
      data['tags'] = tags!.map((final v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }

  List<BookViewModel> bookListFromJson(final List<dynamic> dynamicList) {
    final List<BookViewModel> p = [];
    for (final element in dynamicList) {
      p.add(BookViewModel.fromJson(element));
    }
    return p;
  }
}
