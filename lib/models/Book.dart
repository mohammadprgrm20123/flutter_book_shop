

import'dart:convert';

class Book {
  int id;
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
  String authorName;
  String desc;
  Tags tags=new Tags();

  Book({this.price,this.bookName,this.publisherName,this.translator,this.score
    ,this.category,this.pages,this.releaseDate,this.createdAt,this.url
    ,this.authorName,this.desc,this.tags});
  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    authorName = json['authorName'];
    desc = json['desc'];
    tags = json['tags'] != null ? new Tags.fromJson(json['tags']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['bookName'] = this.bookName;
    data['publisherName'] = this.publisherName;
    data['translator'] = this.translator;
    data['score'] = this.score;
    data['category'] = this.category;
    data['pages'] = this.pages;
    data['releaseDate'] = this.releaseDate;
    data['createdAt'] = this.createdAt;
    data['url'] = this.url;
    data['authorName'] = this.authorName;
    data['desc'] = this.desc;
    if (this.tags != null) {
      data['tags'] = this.tags.toJson();
    }
    return data;
  }
  Map<String, dynamic> toJsonWithoutId() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['bookName'] = this.bookName;
    data['publisherName'] = this.publisherName;
    data['translator'] = this.translator;
    data['score'] = this.score;
    data['category'] = this.category;
    data['pages'] = this.pages;
    data['releaseDate'] = this.releaseDate;
    data['createdAt'] = this.createdAt;
    data['url'] = this.url;
    data['authorName'] = this.authorName;
    data['desc'] = this.desc;
    if (this.tags != null) {
      data['tags'] = this.tags.toJson();
    }
    return data;
  }

  List<Book> BookListFromJson(List<dynamic> dynamicList){
    List<Book> listBook = [];
    dynamicList.forEach((element) {
      listBook.add(Book.fromJson(element));
    });
   return listBook;
  }


}

class Tags {
  String tag0="";
  String tag1="";
  String tag2="";
  String tag3="";
  String tag4="";

  Tags({this.tag0, this.tag1, this.tag2, this.tag3, this.tag4});

  Tags.fromJson(Map<String, dynamic> json) {
    tag0 = json['tag0'];
    tag1 = json['tag1'];
    tag2 = json['tag2'];
    tag3 = json['tag3'];
    tag4 = json['tag4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag0'] = this.tag0;
    data['tag1'] = this.tag1;
    data['tag2'] = this.tag2;
    data['tag3'] = this.tag3;
    data['tag4'] = this.tag4;
    return data;
  }


}