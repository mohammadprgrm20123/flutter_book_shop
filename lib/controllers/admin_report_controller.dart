
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/purches_view_model.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';

import '../server/api_client.dart';

class AdminReportController extends GetxController{

  final RxBool _loading = false.obs;
  final AppRepository _appRepository= AppRepository(ApiClient());
  List<Purchase> _listPurchase = [];
  @override
  void onInit() {
    super.onInit();
    getPurchaseInfo();
  }


  void getPurchaseInfo(){
    _loading(true);
    _appRepository.receivePurchaseInformation().then((final value){
      _loading(false);
      _listPurchase = value;
    }).onError((final error, final stackTrace) {
      _loading(false);
      Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }
  RxBool get loading => _loading;

  List<Purchase> get listPurchase => _listPurchase;
}