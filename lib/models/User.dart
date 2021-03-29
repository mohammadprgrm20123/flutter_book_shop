

class User {
  int _id;
  String _userName;
  String _password;
  String _role;
  String _phone;
  String _email;

  User();



  int get id => _id;

  set id(int id) => _id = id;

  String get userName => _userName;

  set userName(String userName) => _userName = userName;

  String get password => _password;

  set password(String password) => _password = password;

  String get role => _role;

  set role(String role) => _role = role;

  String get phone => _phone;

  set phone(String phone) => _phone = phone;

  String get email => _email;

  set email(String email) => _email = email;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userName = json['userName'];
    _password = json['password'];
    _role = json['role'];
    _phone = json['phone'];
    _email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['userName'] = this._userName;
    data['password'] = this._password;
    data['role'] = this._role;
    data['phone'] = this._phone;
    data['email'] = this._email;
    return data;
  }
}
