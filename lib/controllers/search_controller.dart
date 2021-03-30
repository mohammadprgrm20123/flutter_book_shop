import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/repository/AppRepository.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class SearchController extends GetxController {
  RxBool _loading = false.obs;
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
      _listAll = value;
      _loading(false);
    }).onError((error, stackTrace) {
      _loading(false);
      Get.snackbar("خطا", "لطفا اینترنت خود را چک کنید");
    });
  }

  searchInList(String text) {
    print("serachInlist");
    _loading(true);

    _searchList = _listAll.where((book) => book.bookName.contains(text) ||
        book.autherName.contains(text) ||
        book.publisherName.contains(text) ||
        book.category.contains(text) ||
        book.desc.contains(text)).toList();

    print(_searchList.toString());
    _loading(false);

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

    String categury="";
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

      case 1: return "داستانی" ;break;
      case 2: return "رمان" ;break;
      case 3: return "فلسفه" ; break;
      case 4: return "روانشناسی" ; break;
      case 5: return "حماسی" ;break;
    }

  }

  void filterCateguryInList(String catagury) {
    _searchList = _listAll.where((book) =>book.category==catagury
    ).toList();
  }


}
