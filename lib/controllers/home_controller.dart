 import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/custom_widgets/card_item.dart';
import 'package:flutter_booki_shop/custom_widgets/card_item.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/repository/AppRepository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  RxBool _loading =false.obs;
  List<Book> listAllBook=[] ;
  List<Book> listBestBook=[];
  List<Book> listPopularBook=[];
  List<Book> listAudioBook=[];
  List<ImageCarditem> itemsAudioBook = [
  ];  RxDouble indexIndicator = 0.0.obs;

  AppRepository _appRepository;
  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository();
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
      Get.snackbar("خطا","لطفا اینترنت خود را چک کنید");
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
    List<Book> listAudio = [];

    allBook.forEach((book) {
      if(book.category=="صوتی"){
        listAudioBook.add(book);
        itemsAudioBook.add(ImageCarditem(
          image: Image.network(
              book.url)));
      }
    });

  }






}