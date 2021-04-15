
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class SearchController extends GetxController {
  RxBool _loading = false.obs;
  RxBool _loadingSearch = false.obs;
  AppRepository _appRepository;
  List<Book> _listAll=[];
  List<Book> _searchList=[];

  RxMap<int,dynamic> mapColor = {
    1 : Colors.grey,
    2 :Colors.grey,
    3 :Colors.grey,
    4:Colors.grey,
    5:Colors.grey,
  }.obs;


  RxBool get loading => _loading;

  List<Book> get searchList => _searchList;

  List<Book> get listAll => _listAll;

  @override
  void onInit() {
    super.onInit();
    _appRepository = new AppRepository();
  }

  getAllBooks() {
    _loading(true);
    _appRepository.getAllBooks().then((value) {
      _loading(false);
      _listAll = value;
    }).onError((error, stackTrace) {
      _loading(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  RxBool get loadingSearch => _loadingSearch;

  searchInList(String text) {
    _loadingSearch(true);
    _searchList = _listAll.where((book) => book.bookName.contains(text) ||
        book.publisherName.contains(text) ||
        book.category.contains(text) ||
        book.desc.contains(text)).toList();
    _loadingSearch(false);

  }

  filterInList(RangeValues rangeValues){
    String category = findCategorySelected();
    _loading(true);
    _searchList = _listAll.where((book) =>double.parse(book.price.toString())>=rangeValues.start.roundToDouble()
        && double.parse(book.price.toString())<=rangeValues.end.roundToDouble()
        ).toList();
    filterCategoryInList(category);
    _loading(false);
  }

  String findCategorySelected() {
    int selected = 0;
    for(int i=1;i<=mapColor.length;i++){
      if(mapColor[i]==Colors.blue){
        selected = i;
        break;
      }
    }
   return checkCategory(selected);
  }

  String checkCategory(int selected) {
    switch(selected){
      case 1: return S.of(Get.context).category_stoy ;break;
      case 2: return S.of(Get.context).novel ;break;
      case 3: return S.of(Get.context).philosophy ; break;
      case 4: return S.of(Get.context).psychology ; break;
      case 5: return S.of(Get.context).epic ;break;
    }
    return S.of(Get.context).category_stoy;
  }

  void filterCategoryInList(String catagory) {
    _searchList = _listAll.where((book) =>book.category==catagory
    ).toList();
  }


}
