

import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/repository/AppRepository.dart';
import 'package:get/get.dart';

class EditBookController extends GetxController{


  AppRepository _appRepository;
  RxBool _loading =false.obs;
  Book book=new Book();
  RxString category = "داستانی".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _appRepository =new AppRepository();
  }

  void requestForEditBook(Book book) {
    _loading(true);
    _appRepository.requestForEditBook(book);
    _loading(false);
  }

}