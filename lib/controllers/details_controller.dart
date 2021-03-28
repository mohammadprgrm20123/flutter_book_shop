

import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/repository/AppRepository.dart';
import 'package:get/get.dart';

class DetailController extends GetxController{

  RxBool _loading = false.obs;
  RxBool _loadingBtnClick = false.obs;
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
      print(value.category);
      _loading(false);
      _book =value;
    }).onError((error, stackTrace){
      _loading(false);
      Get.snackbar("خطا", "مشکلی بوجود آمده است");
    });
  }

  addBookToCartShop(Book book){
    _loadingBtnClick(true);
    _appRepository.addBookToCartShop(book).then((value) {
      _loadingBtnClick(false);
    }).onError((error, stackTrace) {
      _loadingBtnClick(false);
      Get.snackbar("خطا", "مشکلی پیش آمده است");
    });
  }

  addBookToFavoriteList(Book book){
    _loadingBtnClick(true);
    _appRepository.addToFavoriteList(book).then((value) {
      _loadingBtnClick(false);
    }).onError((error, stackTrace) {
      _loadingBtnClick(false);
      Get.snackbar("خطا", "مشکلی پیش آمده است");
    });
  }

  RxBool get loadingBtnClick => _loadingBtnClick;
}