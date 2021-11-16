
import 'package:get/get.dart';

import '../models/book_view_model.dart';
import '../models/favorite_item_view_model.dart';
import '../models/cart_shop.dart';
import '../repository/app_repository.dart';
import '../shareprefrence.dart';

class MorePageController extends GetxController{


  RxBool loading=false.obs;
  AppRepository _appRepository;
  List<BookViewModel> allBooks =[];
  List<FavoriteItem> listFavorite=[];
  List<CartShop> listCartShop=[];

  @override
  void onInit() {
    super.onInit();
    _appRepository= AppRepository();
    getAllBooks();
  }

 void  getAllBooks(){
    loading(true);
    _appRepository.getAllBooks().then((final value){
      allBooks=value;
      loading(false);
    }).onError((final error, final stackTrace) {
      loading(false);
    });
  }
  void addToFavorite(final BookViewModel book){
    _appRepository.addBookToFavoriteList(book);
  }

 void  removeFromFavorite(final BookViewModel book){
    for (final element in listFavorite) {
      if(element.book.id==book.id){
        _appRepository.removeItemOfFavoriteList(element.id);
      }
    }
  }

  void getListFavorite() {
    MySharePrefrence().getId().then((final value) {
      _appRepository.getFavoritesBooks(value).then((final value){
        loading(true);
        listFavorite=value;
        setStatusOfFavorite();
      });
    });
  }

  void setStatusOfFavorite() async{
    checkLengthListFavorite();
    for (int i = 0; i < listFavorite.length; i++) {
      for (int j = 0; j < allBooks.length; j++) {
        if (allBooks[j].id == listFavorite[i].book.id) {
          allBooks[j].isFavorite = true;
        }
      }
    }
    await getAllCartShop();
    loading(false);
  }

  void checkLengthListFavorite() {
    if (listFavorite.isEmpty) {
      for (int j = 0; j < allBooks.length; j++) {
        allBooks[j].isFavorite = false;
      }
    } else {
      for (int j = 0; j < allBooks.length; j++) {
        allBooks[j].isFavorite = false;
      }
    }
  }

  void getAllCartShop() async {
    await _appRepository.getShoppingListCart().then((final value) {
      listCartShop = value;
      checkLengthOfListCartShop();
      for (int i = 0; i < listCartShop.length; i++) {
        for (int j = 0; j < allBooks.length; j++) {
          if (allBooks[j].id == listCartShop[i].book.id) {
            allBooks[j].isInCartShop = true;
          }
        }
      }
    });
  }

  void checkLengthOfListCartShop() {
    if (listCartShop.isEmpty) {
      for (int j = 0; j < allBooks.length; j++) {
        allBooks[j].isInCartShop = false;
      }
    } else {
      for (int j = 0; j < allBooks.length; j++) {
        allBooks[j].isInCartShop = false;
      }
    }
  }

  void addToCartShop(final BookViewModel book) {
    _appRepository.addBookToCart(book);
  }

  void removeFromCartShop(final BookViewModel book) {
    CartShop _cartShop;
    for (final element in listCartShop) {
      if (book.id == element.book.id) {
        _cartShop = element;
      }
    }
    _appRepository.removeItemOfShoppingCart(_cartShop);
  }
}