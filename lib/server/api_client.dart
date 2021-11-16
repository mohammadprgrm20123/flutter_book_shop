import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiClient {
  Dio _dio;
  static const String endPointUser = 'users';

  static const String books = 'books';
  static const String cartShops = 'cartShop';
  static const String favorite = 'favorite';
  static const String purchase = 'purchase';

  ApiClient() {
    final BaseOptions options = BaseOptions(
        baseUrl: kIsWeb
            ? 'http://localhost:3000/'
            : 'http://10.0.2.2:3000/');
    _dio = Dio(options);
  }
  Dio get dio => _dio;
}
