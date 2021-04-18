import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiClient {
  Dio _dio;
  static const String END_POINT_USERS = 'users';

  static const String END_POINT_BOOKS = 'books';
  static const String END_POINT_CARTSHOPS = 'cartShop';
  static const String END_POINT_FAVORITE = 'favorite';
  static const String END_POINT_PURCHASE = 'purchase';

  ApiClient() {
    BaseOptions options = new BaseOptions(
        baseUrl: kIsWeb
            ? 'http://localhost:3000/'
            : 'http://10.0.2.2:3000/');
    _dio = new Dio(options);
  }
  Dio get dio => _dio;
}
