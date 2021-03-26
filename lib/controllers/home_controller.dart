 import 'package:flutter_booki_shop/repository/AppRepository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  RxDouble indexIndicator = 0.0.obs;
  AppRepository _appRepository;
  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository().getInstance();
  }

  
}