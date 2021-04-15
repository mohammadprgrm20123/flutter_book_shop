
class Book {
  String _price;
  String _bookName;
  String _publisherName;
  String _translator;
  double _score;
  String _category;
  String _pages;
  String _releaseDate;
  String _createdAt;
  String _url;
  String _autherName;
  String _desc;
  List<Tags> _tags;
  int _id;
  bool isFavorite;
  bool isInCartShop;
  Book(
      {String price,
        String bookName,
        String publisherName,
        String translator,
        double score,
        String category,
        String pages,
        String releaseDate,
        String createdAt,
        String url,
        String autherName,
        String desc,
        List<Tags> tags,
        int id}) {
    this._price = price;
    this._bookName = bookName;
    this._publisherName = publisherName;
    this._translator = translator;
    this._score = score;
    this._category = category;
    this._pages = pages;
    this._releaseDate = releaseDate;
    this._createdAt = createdAt;
    this._url = url;
    this._autherName = autherName;
    this._desc = desc;
    this._tags = tags;
    this._id = id;
  }

  String get price => _price;
  set price(String price) => _price = price;
  String get bookName => _bookName;
  set bookName(String bookName) => _bookName = bookName;
  String get publisherName => _publisherName;
  set publisherName(String publisherName) => _publisherName = publisherName;
  String get translator => _translator;
  set translator(String translator) => _translator = translator;
  double get score => _score;
  set score(double score) => _score = score;
  String get category => _category;
  set category(String category) => _category = category;
  String get pages => _pages;
  set pages(String pages) => _pages = pages;
  String get releaseDate => _releaseDate;
  set releaseDate(String releaseDate) => _releaseDate = releaseDate;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get url => _url;
  set url(String url) => _url = url;
  String get autherName => _autherName;
  set autherName(String autherName) => _autherName = autherName;
  String get desc => _desc;
  set desc(String desc) => _desc = desc;
  List<Tags> get tags => _tags;
  set tags(List<Tags> tags) => _tags = tags;
  int get id => _id;
  set id(int id) => _id = id;

  Book.fromJson(Map<String, dynamic> json) {
    _price = json['price'];
    _bookName = json['bookName'];
    _publisherName = json['publisherName'];
    _translator = json['translator'];
    _score = json['score']+0.0;
    _category = json['category'];
    _pages = json['pages'];
    _releaseDate = json['releaseDate'];
    _createdAt = json['createdAt'];
    _url = json['url'];
    _autherName = json['autherName'];
    _desc = json['desc'];
     _tags = Tags().TagListFromJson(json['tags']);
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this._price;
    data['bookName'] = this._bookName;
    data['publisherName'] = this._publisherName;
    data['translator'] = this._translator;
    data['score'] = this._score;
    data['category'] = this._category;
    data['pages'] = this._pages;
    data['releaseDate'] = this._releaseDate;
    data['createdAt'] = this._createdAt;
    data['url'] = this._url;
    data['autherName'] = this._autherName;
    data['desc'] = this._desc;
    if (this._tags != null) {
      data['tags'] = this._tags.map((v) => v.toJson()).toList();
    }
    data['id'] = this._id;
    return data;
  }
  List<Book> BookListFromJson(List<dynamic> dynamicList){
    List<Book> p = [];
    dynamicList.forEach((element) {
      p.add(Book.fromJson(element));
    });
    return p;
  }
}
class Tags {
  String _tag;

  Tags({String tag}) {
    this._tag = tag;
  }

  String get tag => _tag;
  set tag(String tag) => _tag = tag;

  Tags.fromJson(Map<String, dynamic> json) {
    _tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this._tag;
    return data;
  }


  List<Tags> TagListFromJson(List<dynamic> dynamicList){
    List<Tags> p = [];
    dynamicList.forEach((element) {
      p.add(Tags.fromJson(element));
    });
    return p;
  }

}