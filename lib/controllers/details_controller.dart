import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/models/favorite_item_view_model.dart';
import 'package:flutter_booki_shop/shareprefrence.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

import '../generated/l10n.dart';
import '../models/book_view_model.dart';
import '../repository/app_repository.dart';

class DetailController extends GetxController {
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

  void addBookToFavoriteList(final BookViewModel book) async {
    _loadingBtnClick(true);
    final FavoriteItem favoriteItem = await fillFavoriteValues(book);

    await _appRepository
        .addBookToFavoriteList(favorite: favoriteItem)
        .then((final value) {
      _loadingBtnClick(false);
    }).onError((final error, final stackTrace) {
      _loadingBtnClick(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  Future<FavoriteItem> fillFavoriteValues(final BookViewModel book) async {
    final FavoriteItem favoriteItem = FavoriteItem();
    await MyStorage().getId().then((final value) {
      favoriteItem
        ..userId = value
        ..book = book;
    });
    return favoriteItem;
  }

  RxBool get loadingBtnClick => _loadingBtnClick;


  void shareData() {
    Share.share(
        '${book.bookName} \n ${book.desc} ');
  }
}
