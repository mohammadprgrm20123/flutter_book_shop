import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/book_view_model.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class SearchController extends GetxController {
  RxBool loading = false.obs;
  RxBool loadingSearch = false.obs;
  AppRepository appRepository;
  List<BookViewModel> listAll = [];
  List<BookViewModel> searchList = [];

  RxMap<int, dynamic> mapColor = {
    1: Colors.grey,
    2: Colors.grey,
    3: Colors.grey,
    4: Colors.grey,
    5: Colors.grey,
  }.obs;

  @override
  void onInit() {
    super.onInit();
    appRepository = AppRepository();
  }

  void getAllBooks() async {
    loading(true);
    await appRepository.getAllBooks().then((final value) {
      loading(false);
      listAll = value;
    }).onError((final error, final stackTrace) {
      loading(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  void searchInList(final String text) {
    loadingSearch(true);
    searchList = listAll
        .where((final book) =>
            book.bookName.contains(text) ||
            book.publisherName.contains(text) ||
            book.category.contains(text) ||
            book.desc.contains(text))
        .toList();
    loadingSearch(false);
  }

  void filterInList(final RangeValues rangeValues) {
    final String category = findCategorySelected();
    loading(true);
    searchList = listAll
        .where((final book) =>
            double.parse(book.price) >= rangeValues.start.roundToDouble() &&
            double.parse(book.price) <= rangeValues.end.roundToDouble())
        .toList();
    filterCategoryInList(category);
    loading(false);
  }

  String findCategorySelected() {
    int selected = 0;
    for (int i = 1; i <= mapColor.length; i++) {
      if (mapColor[i] == Colors.blue) {
        selected = i;
        break;
      }
    }
    return checkCategory(selected);
  }

  String checkCategory(final int selected) {
    switch (selected) {
      case 1:
        return S.of(Get.context).category_stoy;
        break;
      case 2:
        return S.of(Get.context).novel;
        break;
      case 3:
        return S.of(Get.context).philosophy;
        break;
      case 4:
        return S.of(Get.context).psychology;
        break;
      case 5:
        return S.of(Get.context).epic;
        break;
    }
    return S.of(Get.context).category_stoy;
  }

  void filterCategoryInList(final String catagory) {
    searchList =
        listAll.where((final book) => book.category == catagory).toList();
  }
}
