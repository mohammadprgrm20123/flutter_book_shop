import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/book_view_model.dart';
import 'package:flutter_booki_shop/models/cart_shop.dart';
import 'package:flutter_booki_shop/models/favorite_item_view_model.dart';
import 'package:flutter_booki_shop/models/purches_view_model.dart';
import 'package:flutter_booki_shop/models/user_view_model.dart';
import 'package:flutter_booki_shop/server/api_client.dart';
import 'package:flutter_booki_shop/shareprefrence.dart';
import 'package:flutter_booki_shop/views/favorite/favorite.dart';
import 'package:get/get.dart';

class AppRepository {
  final ApiClient _apiClient;

  AppRepository(this._apiClient);

  Future<User> checkUserInfo(
      final String userName, final String password) async {
    User user = User();
    await _apiClient.dio.get(ApiClient.endPointUser, queryParameters: {
      'userName': userName,
      'password': password
    }).then((final value) {
      user = User.fromJson(value.data[0]);
    }).onError((final error, final stackTrace) {
      throw S.of(Get.context!).error;
    });
    
    return user;
  }

  Future<List<BookViewModel>> getAllBooks() async {
    List<BookViewModel> listBook = [];
    await _apiClient.dio.get(ApiClient.books).then((final value) {
      listBook = BookViewModel().bookListFromJson(value.data);
    }).onError((final error, final stackTrace) {
      throw S.of(Get.context!).error;
    });
    return listBook;
  }

  Future<BookViewModel> getDetailsBook(final int bookId) async {
    BookViewModel book = BookViewModel();
    await _apiClient.dio.get(ApiClient.books, queryParameters: {
      'id': bookId,
    }).then((final value) {
      book = BookViewModel.fromJson(value.data[0]);
    }).onError((final error, final stackTrace) {
      throw S.of(Get.context!).error;
    });
    return book;
  }

  Future<CartShop> addBookToCart(final BookViewModel book) async {
    final CartShop cartShop = await fillCartValues(book);

    CartShop cart = CartShop();
    await _apiClient.dio
        .post(ApiClient.cartShops, data: cartShop.toJson())
        .then((final value) {
          cart = CartShop.fromJson(value.data);
    });
    return cart;
  }

  Future<FavoriteItem> addBookToFavoriteList(
  {required final FavoriteItem favorite}) async {

     FavoriteItem favoriteItem = FavoriteItem();
    await _apiClient.dio
        .post(ApiClient.favorite, data: favorite.toJson())
        .then((final value) {
      favoriteItem =FavoriteItem.fromJson(value.data);
      Get.snackbar(S.of(Get.context!).record_done,
          S.of(Get.context!).book_add_to_favortie);
      // response = value;
    });
    return favoriteItem;
  }

  Future<CartShop> fillCartValues(final BookViewModel book) async {
    final CartShop cartShop = CartShop()..book = book;
    await MyStorage().getId().then((final value) {
      cartShop.userId = value;
    });
    cartShop.count = 1;
    return cartShop;
  }


  Future<List<FavoriteItem>> getFavoritesBooks(final int userId) async {
    List<FavoriteItem> listFavoritesBooks = [];
    await _apiClient.dio.get(ApiClient.favorite,
        queryParameters: {'userId': userId}).then((final value) {
      listFavoritesBooks = FavoriteItem().bookListFromJson(value.data);
    }).onError((final error, final stackTrace) {
      throw S.of(Get.context!).error;
    });
    return listFavoritesBooks;
  }

  Future<User> getProfileInfo(final int userId) async {
    User user = User();

    await _apiClient.dio.get(ApiClient.endPointUser,
        queryParameters: {'id': userId}).then((final value) {
      user = User.fromJson(value.data[0]);
    }).onError((final error, final stackTrace) {
      throw S.of(Get.context!).error;
    });
    return user;
  }

  Future<User> updateUserInfo(final User user) async {
    await _apiClient.dio
        .put('${ApiClient.endPointUser}/${user.id}', data: user.toJson())
        .then((final value) {})
        .onError((final error, final stackTrace) {
      throw S.of(Get.context!).error;
    });
    return user;
  }

  Future<List<CartShop>> getShoppingListCart() async {
    List<CartShop> list = [];
    await _apiClient.dio.get(ApiClient.cartShops).then((final value) {
      list = CartShop().cartShopListFromJson(value.data);
    }).onError((final error, final stackTrace) {
      Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).has_problem);
    });

    return list;
  }

  Future<void> registerUserPurchase(final Purchase purchase) async {
    await _apiClient.dio
        .post(ApiClient.purchase, data: purchase.toJson())
        .then((final value) {
      Get.snackbar(
          S.of(Get.context!).congratulation, S.of(Get.context!).success_purchase);
    }).onError((final error, final stackTrace) {
      Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).has_problem);
    });
  }

  void removeItemOfShoppingCart(final CartShop cartShop) {
    _apiClient.dio.delete('${ApiClient.cartShops}/${cartShop.id}');
  }

  Future<List<Purchase>> receivePurchaseInformation() async {
    List<Purchase> purchaseList = [];
    await _apiClient.dio.get(ApiClient.purchase).then((final value) {
      purchaseList = Purchase().purchaseListFromJson(value.data);
    }).onError((final error, final stackTrace) {
      Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).has_problem);
    });
    return purchaseList;
  }

  Future<void> addBook(final BookViewModel book) async {
    await _apiClient.dio
        .post(ApiClient.books, data: book.toJson())
        .then((final value) {
      Get.snackbar(
          S.of(Get.context!).congratulation, S.of(Get.context!).record_product,
          backgroundColor: Colors.green[200]);
    }).onError((final error, final stackTrace) {
      Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  Future<void> editBook(final BookViewModel book) async {
    await _apiClient.dio
        .put('${ApiClient.books}/${book.id}', data: book.toJson())
        .then((final value) {
      Get.snackbar(
          S.of(Get.context!).congratulation, S.of(Get.context!).success_edit,
          backgroundColor: Colors.green[200]);
    }).onError((final error, final stackTrace) {
      Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  Future<void> removeItemOfFavoriteList(final int id) async {
    await _apiClient.dio
        .delete('${ApiClient.favorite}/$id')
        .then((final value) {
      Get.snackbar(' حذف شد', 'با موفقیت از لیست علاقه مندی حذف شد');
    }).onError((final error, final stackTrace) {
      Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).has_problem);
      return;
    });
  }
}
