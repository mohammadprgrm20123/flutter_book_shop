
import 'package:dio/dio.dart';

class ApiClient {
  Dio _dio;
  final String _BASE_URL = 'https://192.168.8.3:3000/';
  ApiClient(){
    BaseOptions options = new BaseOptions(
        baseUrl: _BASE_URL
    );
   _dio = new Dio(options);
  }
  Dio get dio => _dio;
}