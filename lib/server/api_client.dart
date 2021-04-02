
import 'package:dio/dio.dart';

class ApiClient {
  Dio _dio;
 static const String _BASE_URL = 'http://10.0.2.2:3000/';
 static const String END_POINT_USERS = 'users';

  static String get BASE_URL => _BASE_URL;
  static const String END_POINT_BOOKS = 'books';
 static const String END_POINT_CARTSHOPS = 'cartShop';
 static const String END_POINT_FAVORITE = 'favorite';
 static const String END_POINT_PURCHASE = 'purchease';

  ApiClient(){
    BaseOptions options = new BaseOptions(
        baseUrl: _BASE_URL
    );
   _dio = new Dio(options);
  }
  Dio get dio => _dio;


}