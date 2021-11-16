
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/book_view_model.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';

class AdminHomeController extends GetxController{

  final RxBool _loading=false.obs;
  AppRepository _appRepository;
  List<BookViewModel> listAllBooks=[];

  RxBool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository();
    getAllBooks();
  }

  void getAllBooks(){
    _loading(true);
    _appRepository.getAllBooks().then((final value) {
      _loading(false);
      listAllBooks = value;
    }).onError((final error, final stackTrace) {
      _loading(false);
      Get.snackbar(S.of(Get.context).error,S.of(Get.context).check_network);
    });
  }

}