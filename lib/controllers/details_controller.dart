import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/models/favorite_item_view_model.dart';
import 'package:flutter_booki_shop/shareprefrence.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

import '../generated/l10n.dart';
import '../models/book_view_model.dart';
import '../repository/app_repository.dart';
import '../server/api_client.dart';

class DetailController extends GetxController {
  final RxBool loading = false.obs;
  final RxBool loadingAddCard = false.obs;
  final RxBool loadingAddFavorite = false.obs;
  Rxn<BookViewModel> book = Rxn(null);

  final AppRepository _appRepository =AppRepository(ApiClient());



  int bookId;


  DetailController(this.bookId);

  @override
  void onInit() {
    getDetailsBook(bookId);
    super.onInit();
  }

  void getDetailsBook(final int id) {
    loading.value =true;
    _appRepository.getDetailsBook(id).then((final value) {
      book.value = value;
    }).onError((final error, final stackTrace) {

      Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).has_problem,
          backgroundColor: Colors.red[200]);
    });
    loading.value =false;
  }

  void addBookToCartShop(final BookViewModel book) {
    loadingAddCard(true);
    _appRepository.addBookToCart(book).then((final value) {
      loadingAddCard(false);
    }).onError((final error, final stackTrace) {
      loadingAddCard(false);
      Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  void addBookToFavoriteList(final BookViewModel book) async {
    loadingAddFavorite(true);
    final FavoriteItem favoriteItem = await fillFavoriteValues(book);

    await _appRepository
        .addBookToFavoriteList(favorite: favoriteItem)
        .then((final value) {
      loadingAddFavorite(false);
    }).onError((final error, final stackTrace) {
      loadingAddFavorite(false);
      Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).has_problem,
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



  void shareData() {
    Share.share(
        '${book.value!.bookName} \n ${book.value!.desc} ');
  }
}
