

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




}