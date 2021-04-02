


import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddBookController extends GetxController{

  AppRepository _appRepository;
  RxBool _loading =false.obs;
  Book book=new Book();
  RxString category = "${S.of(Get.context).category_stoy}".obs;
  String _tag0;
  String _tag1;
  String _tag2;
  String _tag3;
  String _tag4;
  @override
  void onInit() {
    super.onInit();
    _appRepository =new AppRepository();
  }


  set tag0(String value) {
    _tag0 = value;
  }

  String get tag1 => _tag1;

  RxBool get loading => _loading;

  requestForAddBook(Book book) {
    _loading(true);
    _appRepository.requestAddBook(book);
    _loading(false);

  }

  String get tag2 => _tag2;

  String get tag3 => _tag3;

  String get tag4 => _tag4;

  String get tag0 => _tag0;

  set tag1(String value) {
    _tag1 = value;
  }

  set tag2(String value) {
    _tag2 = value;
  }

  set tag3(String value) {
    _tag3 = value;
  }

  set tag4(String value) {
    _tag4 = value;
  }
}