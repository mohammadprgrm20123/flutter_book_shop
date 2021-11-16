 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_widgets/card_item.dart';
import '../generated/l10n.dart';
import '../models/book_view_model.dart';
import '../models/cart_shop.dart';
import '../models/favorite_item_view_model.dart';
import '../repository/app_repository.dart';
import '../shareprefrence.dart';

class HomeController extends GetxController{

  final RxBool loading =false.obs;
  RxList<BookViewModel> listAllBook=[].obs  ;
  RxList<BookViewModel> listBestBook=[].obs  ;
  RxList<BookViewModel> listPopularBook=[].obs ;
  List<BookViewModel> listAudioBook=[];
  RxList<CartShop> listCartShop=[].obs;
  final RxInt countCartShop = 0.obs;
  List<FavoriteItem> listFavorite=[];
  final RxBool loadingOfAddFavoriteAndCartShop=false.obs;


  AppRepository appRepository;
  @override
  void onInit() async {
    super.onInit();
    appRepository = AppRepository();
    getAllBooks();
    getFavoriteList();
    getNumberOfShoppingCart();
  }




  List<ImageCardItem> itemsAudioBook = [
  ];  RxDouble indexIndicator = 0.0.obs;


  void getAllBooks(){
    loading(true);
    appRepository.getAllBooks().then((final value) {
      loading(false);
       listAllBook(value);
    }).onError((final error, final stackTrace) {
      loading(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });


  }


  void separateBestBooks(){
    final List<BookViewModel> listBest = [];
    for (final book in listAllBook) {
     if(book.score>=4.2 && book.category!='صوتی'){
       listBest.add(book);
     }
   }
   listBestBook.value=(listBest);
  }

  void separatePopularBook() {
   listPopularBook(listBestBook.reversed.toList());
  }

  void separateAudioBook() {
    final List<BookViewModel> allBook = listAllBook;
    for (final book in allBook) {
      if(book.category=='صوتی'){
        listAudioBook.add(book);
        itemsAudioBook.add(ImageCardItem(
          image: Image.network(book.url)));
      }
    }

  }

  void getNumberOfShoppingCart() async {
    await appRepository.getShoppingListCart().then((final value) {
      countCartShop.value = value.length;
    });
  }


  void addToFavorite(final BookViewModel book){
    loadingOfAddFavoriteAndCartShop(true);
    appRepository.addBookToFavoriteList(book);
    loadingOfAddFavoriteAndCartShop(false);
  }

  void removeFromFavorite(final BookViewModel book){
    loadingOfAddFavoriteAndCartShop(true);
    for (final element in listFavorite) {
      if(element.book.id==book.id){
        appRepository.removeItemOfFavoriteList(element.id);
      }
    }
    loadingOfAddFavoriteAndCartShop(false);
  }

  void getFavoriteList() {
    MySharePrefrence().getId().then((final value) {
      appRepository.getFavoritesBooks(value).then((final value){
        listFavorite = value;
        setStatusOfFavorite();
      });
    });
  }

  void setStatusOfFavorite() async {
    checkListFavoriteLength();
      for(int i=0;i<listFavorite.length;i++){
        for(int j=0;j<listAllBook.length;j++){
          if(listAllBook[j].id==listFavorite[i].book.id){
            listAllBook[j].isFavorite=true;
          }
        }
      }
    await getAllCartShop();
    separateBestBooks();
    separatePopularBook();
    separateAudioBook();
    for (final element in listAudioBook) {
      print(element.bookName);
    }
  }

  void checkListFavoriteLength() {
       if(listFavorite.isEmpty){
      for(int j=0;j<listAllBook.length;j++){
          listAllBook[j].isFavorite=false;
        }
      }
    else{
      for(int j=0;j<listAllBook.length;j++){
        listAllBook[j].isFavorite=false;
      }
    }
  }

  void addToCartShop(final BookViewModel book){
    appRepository.addBookToCart(book);
  }

  void removeItemFromCartShop(final BookViewModel book){
    CartShop cartShop;
    for (final element in listCartShop) {
      if(book.id==element.book.id)
        {
          cartShop = element;
        }
    }
    appRepository.removeItemOfShoppingCart(cartShop);
  }


  void getAllCartShop() async{
   await appRepository.getShoppingListCart().then((final value) {
      countCartShop.value=value.length;
      listCartShop.value=value;
      checkLengthListCartShop();
      for(int i=0;i<listCartShop.length;i++){
        for(int j=0;j<listAllBook.length;j++){
          if(listAllBook[j].id==listCartShop[i].id){
            listAllBook[j].isInCartShop=true;
          }
        }
      }
    });
  }

  void checkLengthListCartShop() {
    if(listCartShop.isEmpty){
      for(int j=0;j<listAllBook.length;j++){
        listAllBook[j].isInCartShop=false;
      }
    }
    else{
      for(int j=0;j<listAllBook.length;j++){
        listAllBook[j].isInCartShop=false;
      }
    }
  }

}