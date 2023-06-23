import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  Dio _dio = Dio();
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
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 180));

  }
  Dio get dio => _dio;
}
