

import 'package:dio/dio.dart';
import 'package:flutter_booki_shop/models/User.dart';
import 'package:flutter_booki_shop/server/api_client.dart';

class AppRepository {
  ApiClient _apiClient;

  AppRepository(){
    _apiClient = new ApiClient();
  }


  Future<User> validateUser(String userName, String password) async {
    User user;
    await _apiClient.dio.get('users', queryParameters: {
      "userName": userName,
      "password": password
    }).then((value) {
      user = User.fromJson(value.data[0]);
    }).onError((error, stackTrace) {
      throw 'error';
    });
    return user;
  }
}