import 'package:flutter/material.dart';
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
    await _apiClient.dio.get('users', queryParameters: {
      "userName": userName,
      "password": password
    }).then((value) {
      user = User.fromJson(value.data[0]);
    }).onError((error, stackTrace) {
      throw 'error';
    });
    return user;
  }

  Future<List<Book>> getAllBooks() async {
    List<Book> listbook = [];
    await _apiClient.dio.get("books").then((value) {
      listbook = Book().BookListFromJson(value.data);
    }).onError((error, stackTrace) {
      print(error.toString());
      throw "error";
    });
    return listbook;
  }


  Future<Book> getDetailsBook(int bookId) async{
    Book book;
    await _apiClient.dio.get('books', queryParameters: {
      "id": bookId,
    }).then((value) {
      book = Book.fromJson(value.data[0]);
    }).onError((error, stackTrace) {
      throw 'error';
    });
    return book;
  }

  Future<Response<dynamic>> addBookToCartShop(Book book) async {
    CartShop cartShop = await setValuesOFCartShop(book);
    await _apiClient.dio.post("cartShop", data: cartShop.toJson()).then((value) {
      Get.snackbar("ثبت شد", "کتاب مورد نظر به سبد خرید اضافه شد");
      return value;
    });
  }

  Future<Response<dynamic>> addToFavoriteList(Book book) async{
    FavoriteItem favoriteItem = await setValuesFavorite(book);
    await _apiClient.dio.post("favorite", data: favoriteItem.toJson()).then((value) {
      Get.snackbar("ثبت شد", "کتاب مورد نظر به لیست علاقه مندی ها اضافه شد");
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
    await _apiClient.dio.get("favorite",queryParameters: {
      "userId" : userId
    }).then((value) {
      print(value.data.toString());
      listfavoriteBooks = FavoriteItem().BookListFromJson(value.data);
    }).onError((error, stackTrace) {
      throw "error";
    });
    return listfavoriteBooks;
  }


  Future<User> getUserProfile(int userId) async{
    User user;

    await _apiClient.dio.get("users",queryParameters: {
      "id" : userId
    }).then((value) {
      user = User.fromJson(value.data[0]);
    }).onError((error, stackTrace) {
      throw "error";
    });
    return user;
  }


  updateUserData(User user) async {
    print(user.toJson().toString());
    await _apiClient.dio
        .put("users/${user.id}", data: user.toJson())
        .then((value) {
      print(value.data.toString());
    }).onError((error, stackTrace) {
      throw "error";
    });
    return user;
  }


  Future<List<CartShop>> getAllItemsOfCartShops() async{
    List<CartShop> list =new List<CartShop>();
    await _apiClient.dio.get("cartShop").then((value) {
      list = CartShop().CartShopListFromJson(value.data);
    }).onError((error, stackTrace) {
      Get.snackbar("خطا", "مشکلی وبجود آمده است");
    });

    return list;
  }

  requestForPurches(Purches purches){
    _apiClient.dio.post("purches",data: purches.toJson()).then((value) {
      Get.snackbar("تبریک!!!", "خرید با موفقیت انجام شد");
    }).onError((error, stackTrace){
      Get.snackbar("خطا", "مشکلی وبجود آمده است");
    });
  }

  requedtForDelete(CartShop cartShop){
    _apiClient.dio.delete("cartshop/${cartShop.id}");
  }


  Future<List<Purches>> getAllPerches() async{
    List<Purches> purchesList=new List<Purches>();
    await _apiClient.dio.get("purches").then((value) {
      print(value.data.toString());
      purchesList = Purches().purchesListFromJson(value.data);
    }).onError((error, stackTrace) {
      Get.snackbar("خطا", "مشکلی بوجود آمده است");
    });
    return purchesList;
  }

  requestAddBook(Book book) async {
    await _apiClient.dio
        .post("books", data: book.toJsonWithoutId())
        .then((value) {
      Get.snackbar("تبریک!!", "محصول مورد نظر با موفقیت ثبت شد",
          backgroundColor: Colors.green[200]);
    }).onError((error, stackTrace) {
      Get.snackbar("خطا", "مشکلی بوجود آمده است",
          backgroundColor: Colors.red[200]);
    });
  }

  requestForEditBook(Book book) async {
    print(book.id.toString()+"--------");
    await _apiClient.dio
        .put("books/${book.id}", data: book.toJson())
        .then((value) {
      Get.snackbar("تبریک!!", "محصول مورد نظر با موفقیت  ویرایش شد",
          backgroundColor: Colors.green[200]);
    }).onError((error, stackTrace) {
      Get.snackbar("خطا", "مشکلی بوجود آمده است",
          backgroundColor: Colors.red[200]);
    });
  }
}