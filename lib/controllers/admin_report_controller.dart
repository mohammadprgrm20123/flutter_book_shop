

import 'package:flutter_booki_shop/models/purches.dart';
import 'package:flutter_booki_shop/repository/AppRepository.dart';
import 'package:get/get.dart';

class AdminReportController extends GetxController{

  RxBool _loading = false.obs;
  AppRepository _appRepository;
  List<Purches> _listPurches;
  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository();
    getReportPurches();
  }


  RxBool get loading => _loading;

  getReportPurches(){
    _loading(true);
    _appRepository.getAllPerches().then((value){
      print(value.toString());
      _loading(false);
      _listPurches = value;
    }).onError((error, stackTrace) {
      _loading(false);
      Get.snackbar("خطا", "مشکلی بوجود آمده است");
    });
  }

  List<Purches> get listPurches => _listPurches;
}