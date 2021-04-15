
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/purches.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';

class AdminReportController extends GetxController{

  RxBool _loading = false.obs;
  AppRepository _appRepository;
  List<Purchase> _listPurchase;
  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository();
    getReportPurches();
  }


  RxBool get loading => _loading;

  getReportPurches(){
    _loading(true);
    _appRepository.getAllPurchase().then((value){
      _loading(false);
      _listPurchase = value;
    }).onError((error, stackTrace) {
      _loading(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  List<Purchase> get listPurches => _listPurchase;
}