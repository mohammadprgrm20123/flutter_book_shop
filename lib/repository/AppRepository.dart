

import 'package:dio/dio.dart';
import 'package:flutter_booki_shop/server/api_client.dart';

class AppRepository {
  ApiClient _apiClient;

  AppRepository _appRepository;

  AppRepository getInstance(){
    if(_appRepository==null){
      _appRepository = new AppRepository();
    return _appRepository;
    }
    return _appRepository;
  }

  AppRepository(){
    _apiClient = new ApiClient();
  }


  void validateUser(String userName,String password) async{
    Response response;
    response = await _apiClient.dio.get('/user');

    print(response.data.toString());
    print(response.realUri.toString());
    print(response.statusCode);
    print(response.statusMessage);
  }



}