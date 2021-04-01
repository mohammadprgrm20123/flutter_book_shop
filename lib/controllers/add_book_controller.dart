


import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/repository/AppRepository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddBookController extends GetxController{

  AppRepository _appRepository;
  RxBool _loading =false.obs;
  Book book=new Book();
  RxString category = "داستانی".obs;

  @override
  void onInit() {
    super.onInit();
    _appRepository =new AppRepository();
  }


  RxBool get loading => _loading;

  requestForAddBook(Book book) {
    _loading(true);
    _appRepository.requestAddBook(book);
    _loading(false);

  }

}