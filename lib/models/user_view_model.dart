class User {
  int id;
  String userName;
  String password;
  String role;
  String phone;
  String email;
  String image;
  User(
      {final this.id,
      final this.userName,
      final this.password,
      final this.role,
      final this.phone,
      final this.email,
      final this.image});
  User.fromJson(final Map<String, dynamic> json) {
    userName = json['userName'];
    id = json['id'];
    password = json['password'];
    role = json['role'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['password'] = password;
    data['role'] = role;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    return data;
  }


}
