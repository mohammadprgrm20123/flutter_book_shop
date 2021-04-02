


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