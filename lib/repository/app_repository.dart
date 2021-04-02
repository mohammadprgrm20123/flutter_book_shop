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

  Future<User> validateUser(String userName, String password) async {
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
      print('${value.toString()}--->getAllBooks Repo');
      listBook = Book().BookListFromJson(value.data);
      listBook.forEach((element) {
        print('${element.id}--->getAllBooks Repo');
      });
    }).onError((error, stackTrace) {
      print(error.toString());
      throw S.of(Get.context).error;
    });
    return listBook;
  }


  Future<Book> getDetailsBook(int bookId) async{
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

   addBookToCartShop(Book book) async {
    CartShop cartShop = await setValuesOFCartShop(book);
    await _apiClient.dio.post(ApiClient.END_POINT_CARTSHOPS, data: cartShop.toJson()).then((value) {
      Get.snackbar(S.of(Get.context).congratulation, S.of(Get.context).book_add_cart_shop);
      return value;
    });
  }

   addToFavoriteList(Book book) async{
    FavoriteItem favoriteItem = await setValuesFavorite(book);
    await _apiClient.dio.post(ApiClient.END_POINT_FAVORITE, data: favoriteItem.toJson()).then((value) {
      Get.snackbar(S.of(Get.context).record_done, S.of(Get.context).book_add_to_favortie);
      return value;
    });
  }

  Future<CartShop> setValuesOFCartShop(Book book) async {
    CartShop cartShop=new CartShop();
    cartShop.book=book;
    await MySharePrefrence().getId().then((value) {
      cartShop.userid =value;
    });
    cartShop.count = 1;
    return cartShop;
  }

  setValuesFavorite(Book book) async {
    FavoriteItem favoriteItem=new FavoriteItem();
    favoriteItem.book=book;
    await MySharePrefrence().getId().then((value) {
      favoriteItem.userId =value;
    });

    return favoriteItem;
  }


  Future<List<FavoriteItem>> getFavortieBooks(int userId) async{
    List<FavoriteItem> listfavoriteBooks = [];
    await _apiClient.dio.get(ApiClient.END_POINT_FAVORITE,queryParameters: {
      "userId" : userId
    }).then((value) {
      print(value.data.toString());
      listfavoriteBooks = FavoriteItem().BookListFromJson(value.data);
    }).onError((error, stackTrace) {
      throw S.of(Get.context).error;
    });
    return listfavoriteBooks;
  }


  Future<User> getUserProfile(int userId) async{
    User user;

    await _apiClient.dio.get(ApiClient.END_POINT_USERS,queryParameters: {
      "id" : userId
    }).then((value) {
      user = User.fromJson(value.data[0]);
    }).onError((error, stackTrace) {
      throw S.of(Get.context).error;
    });
    return user;
  }


  updateUserData(User user) async {
    print(user.toJson().toString());
    await _apiClient.dio
        .put("${ApiClient.END_POINT_USERS}/${user.id}", data: user.toJson())
        .then((value) {
      print(value.data.toString());
    }).onError((error, stackTrace) {
      throw S.of(Get.context).error;
    });
    return user;
  }


  Future<List<CartShop>> getAllItemsOfCartShops() async{
    List<CartShop> list =[];
    await _apiClient.dio.get(ApiClient.END_POINT_CARTSHOPS).then((value) {
      list = CartShop().CartShopListFromJson(value.data);
    }).onError((error, stackTrace) {
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem);
    });

    return list;
  }

  requestForPurches(Purchase purches){
    _apiClient.dio.post(ApiClient.END_POINT_PURCHASE,data: purches.toJson()).then((value) {
      Get.snackbar(S.of(Get.context).congratulation, S.of(Get.context).success_purchase);
    }).onError((error, stackTrace){
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem);
    });
  }

  requedtForDelete(CartShop cartShop){
    _apiClient.dio.delete("${ApiClient.END_POINT_CARTSHOPS}/${cartShop.id}");
  }


  Future<List<Purchase>> getAllPerches() async{
    List<Purchase> purchaseList=[];
    await _apiClient.dio.get(ApiClient.END_POINT_PURCHASE).then((value) {
      print(value.data.toString());
      purchaseList = Purchase().purchesListFromJson(value.data);
    }).onError((error, stackTrace) {
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem);
    });
    return purchaseList;
  }

  requestAddBook(Book book) async {
    await _apiClient.dio
        .post(ApiClient.END_POINT_BOOKS, data: book.toJsonWithoutId())
        .then((value) {
      Get.snackbar(S.of(Get.context).congratulation, S.of(Get.context).record_product,
          backgroundColor: Colors.green[200]);
    }).onError((error, stackTrace) {
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  requestForEditBook(Book book) async {
    await _apiClient.dio
        .put("${ApiClient.END_POINT_BOOKS}/${book.id}", data: book.toJson())
        .then((value) {
      Get.snackbar(S.of(Get.context).congratulation, S.of(Get.context).success_edit,
          backgroundColor: Colors.green[200]);
    }).onError((error, stackTrace) {
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }
}