import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/models/CartShop.dart';
import 'package:flutter_booki_shop/models/FavoriteItem.dart';
import 'package:flutter_booki_shop/models/User.dart';
import 'package:flutter_booki_shop/models/purches.dart';
import 'package:flutter_booki_shop/server/api_client.dart';
import 'package:flutter_booki_shop/shareprefrence.dart';
import 'package:get/get.dart';

class AppRepository {
  ApiClient _apiClient;

  AppRepository() {
    _apiClient = new ApiClient();
  }

  Future<User> checkUserInfo(String userName, String password) async {
    User user;
    await _apiClient.dio.get(ApiClient.END_POINT_USERS, queryParameters: {
      "userName": userName,
      "password": password
    }).then((value) {
      user = User.fromJson(value.data[0]);
    }).onError((error, stackTrace) {
      throw S.of(Get.context).error;
    });
    return user;
  }

  Future<List<Book>> getAllBooks() async {
    List<Book> listBook = [];
    await _apiClient.dio.get(ApiClient.END_POINT_BOOKS).then((value) {
      listBook = Book().BookListFromJson(value.data);
    }).onError((error, stackTrace) {
      throw S.of(Get.context).error;
    });
    return listBook;
  }

  Future<Book> getDetailsBook(int bookId) async {
    Book book;
    await _apiClient.dio.get(ApiClient.END_POINT_BOOKS, queryParameters: {
      "id": bookId,
    }).then((value) {
      book = Book.fromJson(value.data[0]);
    }).onError((error, stackTrace) {
      throw S.of(Get.context).error;
    });
    return book;
  }

  addBookToCart(Book book) async {
    CartShop cartShop = await fillCartValues(book);
    await _apiClient.dio
        .post(ApiClient.END_POINT_CARTSHOPS, data: cartShop.toJson())
        .then((value) {
      Get.snackbar(S.of(Get.context).congratulation,
          S.of(Get.context).book_add_cart_shop);
      return value;
    });
  }

  addBookToFavoriteList(Book book) async {
    FavoriteItem favoriteItem = await fillFavoriteValues(book);
    await _apiClient.dio
        .post(ApiClient.END_POINT_FAVORITE, data: favoriteItem.toJson())
        .then((value) {
      Get.snackbar(S.of(Get.context).record_done,
          S.of(Get.context).book_add_to_favortie);
      return value;
    });
  }

  Future<CartShop> fillCartValues(Book book) async {
    CartShop cartShop = new CartShop();
    cartShop.book = book;
    await MySharePrefrence().getId().then((value) {
      cartShop.userid = value;
    });
    cartShop.count = 1;
    return cartShop;
  }

  fillFavoriteValues(Book book) async {
    FavoriteItem favoriteItem = new FavoriteItem();
    favoriteItem.book = book;
    await MySharePrefrence().getId().then((value) {
      favoriteItem.userId = value;
    });

    return favoriteItem;
  }

  Future<List<FavoriteItem>> getFavoritesBooks(int userId) async {
    List<FavoriteItem> listFavoritesBooks = [];
    await _apiClient.dio.get(ApiClient.END_POINT_FAVORITE,
        queryParameters: {"userId": userId}).then((value) {
      listFavoritesBooks = FavoriteItem().BookListFromJson(value.data);
    }).onError((error, stackTrace) {
      throw S.of(Get.context).error;
    });
    return listFavoritesBooks;
  }

  Future<User> getProfileInfo(int userId) async {
    User user;

    await _apiClient.dio.get(ApiClient.END_POINT_USERS,
        queryParameters: {"id": userId}).then((value) {
      user = User.fromJson(value.data[0]);
    }).onError((error, stackTrace) {
      throw S.of(Get.context).error;
    });
    return user;
  }

  updateUserInfo(User user) async {
    await _apiClient.dio
        .put("${ApiClient.END_POINT_USERS}/${user.id}", data: user.toJson())
        .then((value) {})
        .onError((error, stackTrace) {
      throw S.of(Get.context).error;
    });
    return user;
  }

  Future<List<CartShop>> getShoppingListCart() async {
    List<CartShop> list = [];
    await _apiClient.dio.get(ApiClient.END_POINT_CARTSHOPS).then((value) {
      list = CartShop().CartShopListFromJson(value.data);
    }).onError((error, stackTrace) {
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem);
    });

    return list;
  }

  registerUserPurchase(Purchase purchase) {
    _apiClient.dio
        .post(ApiClient.END_POINT_PURCHASE, data: purchase.toJson())
        .then((value) {
      Get.snackbar(
          S.of(Get.context).congratulation, S.of(Get.context).success_purchase);
    }).onError((error, stackTrace) {
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem);
    });
  }

  removeItemOfShoppingCart(CartShop cartShop) {
    _apiClient.dio.delete("${ApiClient.END_POINT_CARTSHOPS}/${cartShop.id}");
  }

  Future<List<Purchase>> receivePurchaseInformation() async {
    List<Purchase> purchaseList = [];
    await _apiClient.dio.get(ApiClient.END_POINT_PURCHASE).then((value) {
      purchaseList = Purchase().purchesListFromJson(value.data);
    }).onError((error, stackTrace) {
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem);
    });
    return purchaseList;
  }

  addBook(Book book) async {
    await _apiClient.dio
        .post(ApiClient.END_POINT_BOOKS, data: book.toJson())
        .then((value) {
      Get.snackbar(
          S.of(Get.context).congratulation, S.of(Get.context).record_product,
          backgroundColor: Colors.green[200]);
    }).onError((error, stackTrace) {
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  editBook(Book book) async {
    await _apiClient.dio
        .put("${ApiClient.END_POINT_BOOKS}/${book.id}", data: book.toJson())
        .then((value) {
      Get.snackbar(
          S.of(Get.context).congratulation, S.of(Get.context).success_edit,
          backgroundColor: Colors.green[200]);
    }).onError((error, stackTrace) {
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  removeItemOfFavoriteList(int id) {
    _apiClient.dio.delete("${ApiClient.END_POINT_FAVORITE}/$id").then((value) {
      Get.snackbar(" حذف شد", "با موفقیت از لیست علاقه مندی حذف شد");
    }).onError((error, stackTrace) {
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem);
      return;
    });
  }
}