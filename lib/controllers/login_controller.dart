

import 'package:flutter_booki_shop/repository/AppRepository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{


  AppRepository _appRepository;
  RxBool _validateUsername = false.obs;
  RxBool _validatePasswrod = false.obs;
  RxBool _obscureText = true.obs;

  RxBool get obscureText => _obscureText;

  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository().getInstance();
  }


  RxBool get validateUsername => _validateUsername;

  void requestValidateUser(String userName,String password){
    Response response ;
    _appRepository.getInstance().validateUser(userName, password);

  }

  RxBool get validatePasswrod => _validatePasswrod;
}