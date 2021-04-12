 import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/custom_widgets/card_item.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/models/FavoriteItem.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:flutter_booki_shop/shareprefrence.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  RxBool _loading =false.obs;
  RxList listAllBook=[].obs  ;
  RxList listBestBook=[].obs  ;
  RxList listPopularBook=[].obs ;
  RxList listAudioBook=[].obs;
  RxInt _countCartShop = 0.obs;
  List<FavoriteItem> listFavorite=[];
  RxBool _loadingOfAddFavoriteAndCartShop=false.obs;


  RxBool get loadingOfAddFavorite =>
      _loadingOfAddFavoriteAndCartShop;

  set loadingOfAddFavorite(RxBool value) {
    _loadingOfAddFavoriteAndCartShop = value;
  }

  List<ImageCarditem> itemsAudioBook = [
  ];  RxDouble indexIndicator = 0.0.obs;

  AppRepository _appRepository;
  @override
  void onInit() async {
    super.onInit();
    _appRepository = AppRepository();
    getAllBooks();
    getListFavorite();
    getCountOfCartShop();
  }

  RxBool get loading => _loading;

  getAllBooks(){
    _loading(true);
    _appRepository.getAllBooks().then((value) {
      _loading(false);
       listAllBook(value);
    }).onError((error, stackTrace) {
      _loading(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });


  }


  void seprateBestBooks(){
    List<Book> listBest = [];
    listAllBook.value.forEach((book) {
     if(book.score>=4.2 && book.category!="صوتی"){
       listBest.add(book);
     }
   });
   listBestBook.value=(listBest);
  }

  void sepratePopularBook() {
    listPopularBook=listBestBook;
   listPopularBook(listPopularBook.reversed.toList());
  }

  void seprateAudioBook() {
    List<Book> allBook = listAllBook.value;
    allBook.forEach((book) {
      if(book.category=="صوتی"){
        listAudioBook.value.add(book);
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



  addToFavorite(Book book){
    _loadingOfAddFavoriteAndCartShop(true);
    _appRepository.addToFavoriteList(book);
    _loadingOfAddFavoriteAndCartShop(false);
  }

  removeFromFavorite(Book book){
    _loadingOfAddFavoriteAndCartShop(true);
    listFavorite.forEach((element) {
      if(element.book.id==book.id){
        _appRepository.removeFromFavorite(element.id);
      }
    });
    _loadingOfAddFavoriteAndCartShop(false);
  }

  void getListFavorite() {
    MySharePrefrence().getId().then((value) {
      _appRepository.getFavortieBooks(value).then((value){
        listFavorite = value;
        setStatusOfFavorite();
      });
    });
  }

  void setStatusOfFavorite() {

    if(listFavorite.length==0){
      for(int j=0;j<listAllBook.length;j++){
          listAllBook[j].isFavorite=false;
        }
      }
    else{
      for(int j=0;j<listAllBook.length;j++){
        listAllBook[j].isFavorite=false;
      }
    }


      for(int i=0;i<listFavorite.length;i++){
        for(int j=0;j<listAllBook.length;j++){
          if(listAllBook[j].id==listFavorite[i].book.id){
            listAllBook[j].isFavorite=true;
          }
        }
      }

    seprateBestBooks();
    sepratePopularBook();
    seprateAudioBook();
  }
}