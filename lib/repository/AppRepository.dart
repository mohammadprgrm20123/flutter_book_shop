import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/models/User.dart';
import 'package:flutter_booki_shop/server/api_client.dart';

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
}