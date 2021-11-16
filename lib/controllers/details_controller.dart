import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../generated/l10n.dart';
import '../models/book_view_model.dart';
import '../repository/app_repository.dart';

class DetailController extends GetxController with StateMixin<Null> {
  final RxBool _loading = false.obs;
  final RxBool _loadingBtnClick = false.obs;
  BookViewModel _book;

  AppRepository _appRepository;

  RxBool get loading => _loading;

  BookViewModel get book => _book;

  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository();
  }

  void getDetailsBook(final int id) {
    _loading(true);
    _appRepository.getDetailsBook(id).then((final value) {
      _loading(false);
      print(value.toString());
      _book = value;
    }).onError((final error, final stackTrace) {
      _loading(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  void addBookToCartShop(final BookViewModel book) {
    _loadingBtnClick(true);
    _appRepository.addBookToCart(book).then((final value) {
      _loadingBtnClick(false);
    }).onError((final error, final stackTrace) {
      _loadingBtnClick(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  void addBookToFavoriteList(final BookViewModel book) {
    _loadingBtnClick(true);
    _appRepository.addBookToFavoriteList(book).then((final value) {
      _loadingBtnClick(false);
    }).onError((final error, final stackTrace) {
      _loadingBtnClick(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  RxBool get loadingBtnClick => _loadingBtnClick;
}
