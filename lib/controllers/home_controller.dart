 import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/custom_widgets/card_item.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  RxBool _loading =false.obs;
  List<Book> listAllBook=[] ;
  List<Book> listBestBook=[];
  List<Book> listPopularBook=[];
  List<Book> listAudioBook=[];
  RxInt _countCartShop = 0.obs;
  List<ImageCarditem> itemsAudioBook = [
  ];  RxDouble indexIndicator = 0.0.obs;

  AppRepository _appRepository;
  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository();
    getAllBooks();
    getCountOfCartShop();
  }

  RxBool get loading => _loading;

  getAllBooks(){
    _loading(true);
    _appRepository.getAllBooks().then((value) {
      _loading(false);
       listAllBook = value;
      seprateBestBooks();
      sepratePopularBook();
      seprateAudioBook();
    }).onError((error, stackTrace) {
      _loading(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });


  }


  void seprateBestBooks(){
    List<Book> listBest = [];
    listAllBook;

   listAllBook.forEach((book) {
     if(book.score>=4.2 && book.category!="صوتی"){
       listBest.add(book);
     }
   });
   listBestBook= listBest;
  }

  void sepratePopularBook() {
    listPopularBook=listBestBook;
   listPopularBook= listPopularBook.reversed.toList();
  }

  void seprateAudioBook() {
    List<Book> allBook = listAllBook;
    allBook.forEach((book) {
      if(book.category=="صوتی"){
        listAudioBook.add(book);
        itemsAudioBook.add(ImageCarditem(
          image: Image.network(
              book.url)));
      }
    });

  }

  void getCountOfCartShop() async {
    _appRepository.getAllItemsOfCartShops().then((value) {
      _countCartShop.value = value.length;
    });
  }

  RxInt get countCartShop => _countCartShop;
}