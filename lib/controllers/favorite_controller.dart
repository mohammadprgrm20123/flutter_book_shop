
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/FavoriteItem.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FavoriteController extends GetxController{
  RxBool _loading =false.obs;
  AppRepository _appRepository;
  Set<FavoriteItem> _listFavorite=Set<FavoriteItem>();
  RxBool get loading => _loading;
  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository();
  }



  getFavoriteBooks(int userId){
    _loading(true);
    _appRepository.getFavortieBooks(userId).then((value) {
      _loading(false);
      _listFavorite =value.toSet();
      print(_listFavorite.length.toString());
    }).onError((error, stackTrace) {
      _loading(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  Set<FavoriteItem> get listFavorite => _listFavorite;
}