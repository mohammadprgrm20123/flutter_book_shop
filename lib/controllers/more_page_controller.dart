
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/models/CartShop.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';

import '../shareprefrence.dart';

class MorePageController extends GetxController{


  RxBool _loading=false.obs;
  AppRepository _appRepository;
  RxList allBooks =[].obs;
  RxList listFavorite=[].obs;
  RxList listCartShop=[].obs;
  RxBool get loading => _loading;

  set loading(RxBool value) {
    _loading = value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _appRepository=new AppRepository();
    getAllBooks();
  }

  getAllBooks(){
    _loading(true);
    _appRepository.getAllBooks().then((value){
      allBooks(value);
      _loading(false);
    }).onError((error, stackTrace) {
      _loading(false);
    });
  }
  addToFavorite(Book book){
    _appRepository.addToFavoriteList(book);
  }

  removeFromFavorite(Book book){
    listFavorite.forEach((element) {
      if(element.book.id==book.id){
        _appRepository.removeFromFavorite(element.id);
      }
    });
  }

  void getListFavorite() {
    MySharePrefrence().getId().then((value) {
      _appRepository.getFavortieBooks(value).then((value){
        loading(true);
        listFavorite(value);
        setStatusOfFavorite();
      });
    });
  }

  void setStatusOfFavorite() async{

    if(listFavorite.length==0){
      for(int j=0;j<allBooks.length;j++){
        allBooks[j].isFavorite=false;
      }
    }
    else{
      for(int j=0;j<allBooks.length;j++){
        allBooks[j].isFavorite=false;
      }
    }

    for(int i=0;i<listFavorite.length;i++){
      for(int j=0;j<allBooks.length;j++){
        if(allBooks[j].id==listFavorite[i].book.id){
          allBooks[j].isFavorite=true;
        }
      }
    }
   await getAllCartShop();
    _loading(false);
  }

  getAllCartShop() async{
    await _appRepository.getAllItemsOfCartShops().then((value) {
      listCartShop.value=value;

      if(listCartShop.length==0){
        for(int j=0;j<allBooks.length;j++){
          allBooks[j].isInCartShop=false;
        }
      }
      else{
        for(int j=0;j<allBooks.length;j++){
          allBooks[j].isInCartShop=false;
        }
      }


      for(int i=0;i<listCartShop.length;i++){
        for(int j=0;j<allBooks.length;j++){
          if(allBooks[j].id==listCartShop[i].book.id){
            allBooks[j].isInCartShop=true;
          }
        }
      }
    });
  }

  addToCartShop(Book book){
    _appRepository.addBookToCartShop(book);
  }

  removeFromCartShop(Book book){
    CartShop _cartShop;
    listCartShop.forEach((element) {
      if(book.id==element.book.id)
      {
        _cartShop = element;
      }
    });
    _appRepository.requedtForDelete(_cartShop);
  }
}