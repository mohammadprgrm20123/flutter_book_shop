
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class SearchController extends GetxController {
  RxBool _loading = false.obs;
  RxBool _loadingSeach = false.obs;
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
      value.forEach((element) {
        print('${element.authorName}--->getAllBooks');
      });

      _listAll = value;

    }).onError((error, stackTrace) {
      _loading(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  RxBool get loadingSeach => _loadingSeach;

  searchInList(String text) {
    print("searchInList");
    _loadingSeach(true);

    _searchList = _listAll.where((book) => book.bookName.contains(text) ||

        book.publisherName.contains(text) ||
        book.category.contains(text) ||
        book.desc.contains(text)).toList();
    _searchList.forEach((element) {
      print(element.authorName);
    });
    _loadingSeach(false);

  }


  filterInList(RangeValues rangeValues){
    String catagury = findCategurySelected();
    _loading(true);
    _searchList = _listAll.where((book) =>double.parse(book.price.toString())>=rangeValues.start.roundToDouble()
        && double.parse(book.price.toString())<=rangeValues.end.roundToDouble()
        ).toList();
    filterCateguryInList(catagury);
    _loading(false);
  }

  String findCategurySelected() {
    int selected = 0;
    for(int i=1;i<=mapColor.length;i++){
      if(mapColor[i]==Colors.blue){
        selected = i;
        break;
      }
    }
   return checkCategury(selected);
  }

  String checkCategury(int selected) {
    switch(selected){

      case 1: return S.of(Get.context).category_stoy ;break;
      case 2: return S.of(Get.context).novel ;break;
      case 3: return S.of(Get.context).philosophy ; break;
      case 4: return S.of(Get.context).psychology ; break;
      case 5: return S.of(Get.context).epic ;break;
    }
    return S.of(Get.context).category_stoy;

  }

  void filterCateguryInList(String catagury) {
    _searchList = _listAll.where((book) =>book.category==catagury
    ).toList();
  }


}
