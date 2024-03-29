import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_widgets/card_item.dart';
import '../generated/l10n.dart';
import '../models/book_view_model.dart';
import '../models/cart_shop.dart';
import '../models/favorite_item_view_model.dart';
import '../repository/app_repository.dart';
import '../server/api_client.dart';
import '../shareprefrence.dart';

class HomeController extends GetxController {
  final RxBool loading = false.obs;
  RxList<BookViewModel> listAllBook = <BookViewModel>[].obs;

  RxList<BookViewModel> listBestBook = <BookViewModel>[].obs;

  RxList<BookViewModel> listPopularBook = <BookViewModel>[].obs;

  List<BookViewModel> listAudioBook = <BookViewModel>[];
  RxList<CartShop> listCartShop = <CartShop>[].obs;
  final RxInt countCartShop = 0.obs;
  List<FavoriteItem> listFavorite = <FavoriteItem>[];
  final RxBool loadingOfAddFavoriteAndCartShop = false.obs;

  final AppRepository appRepository =AppRepository(ApiClient());

  RxList<ImageCardItem> itemsAudioBook = <ImageCardItem>[].obs;
  RxDouble indexIndicator = 0.0.obs;

  @override
  void onReady() async {
    super.onReady();
    getAllBooks();
    getFavoriteList();
    getNumberOfShoppingCart();
  }

  void getAllBooks() async {
    loading(true);
    await appRepository.getAllBooks().then((final value) {
      loading(false);
      listAllBook.value = value;
    }).onError((final error, final stackTrace) {
      loading(false);
      Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  void separateBestBooks() {
    final List<BookViewModel> listBest = [];
    for (final book in listAllBook) {
      if (book.category != 'صوتی') {
        listBest.add(book);
      }
    }
    listBestBook.value = listBest;
  }

  void separatePopularBook() {
    listPopularBook(listBestBook.reversed.toList());
  }

  void separateAudioBook() {
    final List<BookViewModel> allBook = listAllBook;
    for (final book in allBook) {
      if (book.category == 'صوتی') {
        listAudioBook.add(book);
        itemsAudioBook.add(ImageCardItem(image: Image.network(book.url!),id: book.id!));
      }
    }
  }

  void getNumberOfShoppingCart() async {
    await appRepository.getShoppingListCart().then((final value) {
      countCartShop.value = value.length;
    });
  }

  void addToFavorite(final BookViewModel book) async {
    loadingOfAddFavoriteAndCartShop(true);
    final FavoriteItem favoriteItem = await fillFavoriteValues(book);
    await appRepository
        .addBookToFavoriteList(favorite: favoriteItem)
        .then((final value) {
      listFavorite.add(value);
    });

    loadingOfAddFavoriteAndCartShop(false);
  }

  Future<FavoriteItem> fillFavoriteValues(final BookViewModel book) async {
    final FavoriteItem favoriteItem = FavoriteItem();
    await MyStorage().getId().then((final value) {
      favoriteItem
        ..userId = value
        ..book = book;
    });
    return favoriteItem;
  }

  void removeFromFavorite(final BookViewModel book) {
    loadingOfAddFavoriteAndCartShop(true);
    for (final element in listFavorite) {
      if (element.book!.id == book.id) {
        appRepository.removeItemOfFavoriteList(element.id!);
        listFavorite.remove(element);
        return;
      }
    }
    loadingOfAddFavoriteAndCartShop(false);
  }

  void getFavoriteList() {
    MyStorage().getId().then((final value) {
      appRepository.getFavoritesBooks(value).then((final value) {
        listFavorite = value;
        setStatusOfFavorite();
      });
    });
  }

  void setStatusOfFavorite() async {
    checkListFavoriteLength();
    for (int i = 0; i < listFavorite.length; i++) {
      for (int j = 0; j < listAllBook.length; j++) {
        if (listAllBook[j].id == listFavorite[i].book!.id) {
          listAllBook[j].isFavorite = true;
        }
      }
    }
    getAllCartShop();
    separateBestBooks();
    separatePopularBook();
    separateAudioBook();
  }

  void checkListFavoriteLength() {
    for (int j = 0; j < listAllBook.length; j++) {
      listAllBook[j].isFavorite = false;
    }
  }

  void addToCartShop(final BookViewModel book) {
    appRepository.addBookToCart(book).then((final value) async {
      listCartShop.add(value);
      countCartShop.value++;
    });
  }

  void removeItemFromCartShop(final BookViewModel book) {
    for (final element in listCartShop) {
      if (book.id == element.book!.id) {
        appRepository.removeItemOfShoppingCart(element);
        listCartShop.remove(element);
        countCartShop.value--;
        return;
      }
    }
  }

  void getAllCartShop() async {
    await appRepository.getShoppingListCart().then((final value) {
      countCartShop.value = value.length;
      listCartShop.value = value;
      checkLengthListCartShop();
      for (int i = 0; i < listCartShop.length; i++) {
        for (int j = 0; j < listAllBook.length; j++) {
          if (listAllBook[j].id == listCartShop[i].id) {
            listAllBook[j].isInCartShop = true;
          }
        }
      }
    });
  }

  void checkLengthListCartShop() {
      for (int j = 0; j < listAllBook.length; j++) {
        listAllBook[j].isInCartShop = false;
      }
  }
}
