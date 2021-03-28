

import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/repository/AppRepository.dart';
import 'package:get/get.dart';

class DetailController extends GetxController{

  RxBool _loading = false.obs;
  Book _book ;
  AppRepository _appRepository;
  RxBool get loading => _loading;


  Book get book => _book;

  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository();
  }

  getDeatilsBook(int id){
    _loading(true);
    _appRepository.getDetailsBook(id).then((value) {
      _loading(false);
      _book =value;
    }).onError((error, stackTrace){
      _loading(false);
      Get.snackbar("خطا", "مشکلی بوجود آمده است");
    });
  }

}