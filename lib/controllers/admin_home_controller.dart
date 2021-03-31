



import 'package:flutter_booki_shop/models/Book.dart';
import 'package:flutter_booki_shop/models/purches.dart';
import 'package:flutter_booki_shop/repository/AppRepository.dart';
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
      _loading(false);
      listAllBooks = value;
    }).onError((error, stackTrace) {
      _loading(false);
      Get.snackbar("خطا","لطفا اینترنت خود را چک کنید");
    });
  }

}