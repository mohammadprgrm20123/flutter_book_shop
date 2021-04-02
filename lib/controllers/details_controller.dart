

import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
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
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);    });
  }

  addBookToCartShop(Book book){
    _loadingBtnClick(true);
    _appRepository.addBookToCartShop(book).then((value) {
      _loadingBtnClick(false);
    }).onError((error, stackTrace) {
      _loadingBtnClick(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);    });
  }

  addBookToFavoriteList(Book book){
    _loadingBtnClick(true);
    _appRepository.addToFavoriteList(book).then((value) {
      _loadingBtnClick(false);
    }).onError((error, stackTrace) {
      _loadingBtnClick(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);    });
  }

  RxBool get loadingBtnClick => _loadingBtnClick;
}