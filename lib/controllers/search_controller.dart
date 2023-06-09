import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../generated/l10n.dart';
import '../models/book_view_model.dart';
import '../repository/app_repository.dart';
import '../server/api_client.dart';

class SearchScreenController extends GetxController {
  RxBool loading = false.obs;
  RxBool loadingSearch = false.obs;
  AppRepository appRepository = AppRepository(ApiClient());
  List<BookViewModel> listAll = [];
  List<BookViewModel> searchList = [];

  RxMap<int, dynamic> mapColor = {
    1: Colors.grey,
    2: Colors.grey,
    3: Colors.grey,
    4: Colors.grey,
    5: Colors.grey,
  }.obs;

  void getAllBooks() async {
    loading(true);
    await appRepository.getAllBooks().then((final value) {
      loading(false);
      listAll = value;
    }).onError((final error, final stackTrace) {
      loading(false);
      Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  void searchInList(final String text) {
    loadingSearch(true);
    searchList = listAll
        .where((final book) =>
            book.bookName!.contains(text) ||
            book.publisherName!.contains(text) ||
            book.category!.contains(text) ||
            book.desc!.contains(text))
        .toList();
    loadingSearch(false);
  }

  void filterInList(final RangeValues rangeValues) {
    final String category = findCategorySelected();
    loading(true);
    searchList = listAll
        .where((final book) =>
            double.parse(book.price!) >= rangeValues.start.roundToDouble() &&
            double.parse(book.price!) <= rangeValues.end.roundToDouble())
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
        return S.of(Get.context!).category_stoy;
      case 2:
        return S.of(Get.context!).novel;
      case 3:
        return S.of(Get.context!).philosophy;
      case 4:
        return S.of(Get.context!).psychology;
      case 5:
        return S.of(Get.context!).epic;
    }
    return S.of(Get.context!).category_stoy;
  }

  void filterCategoryInList(final String catagory) {
    searchList =
        listAll.where((final book) => book.category == catagory).toList();
  }
}
