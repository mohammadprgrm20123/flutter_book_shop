class Purches {
  int _id;
  int _userId;
  String _date;
  String _price;

  Purches({int id, int userId, String date, String price}) {
    this._id = id;
    this._userId = userId;
    this._date = date;
    this._price = price;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get userId => _userId;
  set userId(int userId) => _userId = userId;
  String get date => _date;
  set date(String date) => _date = date;
  String get price => _price;
  set price(String price) => _price = price;

  Purches.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['userId'];
    _date = json['date'];
    _price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['userId'] = this._userId;
    data['date'] = this._date;
    data['price'] = this._price;
    return data;
  }
  List<Purches> purchesListFromJson(List<dynamic> dynamicList){
    List<Purches> p = [];
    dynamicList.forEach((element) {
      p.add(Purches.fromJson(element));
    });
    return p;
  }
}