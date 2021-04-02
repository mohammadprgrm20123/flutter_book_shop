
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';

class AdminHomeController extends GetxController{

  RxBool _loading=false.obs;
  AppRepository _appRepository;
  List<Book> listAllBooks=[];

  RxBool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository();
    getAllBooks();
  }

  getAllBooks(){
    _loading(true);
    _appRepository.getAllBooks().then((value) {
      print(value.toString());
      _loading(false);
      listAllBooks = value;
    }).onError((error, stackTrace) {
      _loading(false);
      Get.snackbar(S.of(Get.context).error,S.of(Get.context).check_network);
    });
  }

}