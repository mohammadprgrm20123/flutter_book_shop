import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../generated/l10n.dart';
import '../models/favorite_item_view_model.dart';
import '../repository/app_repository.dart';

class FavoriteController extends GetxController {
  final RxBool _loading = false.obs;
  AppRepository _appRepository;
  Set<FavoriteItem> _listFavorite = <FavoriteItem>{};

  RxBool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository();
  }

  void getFavoriteBooks(final int userId) {
    _loading(true);
    _appRepository.getFavoritesBooks(userId).then((final value) {
      _loading(false);
      _listFavorite = value.toSet();
    }).onError((final error, final stackTrace) {
      _loading(false);
      Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
          backgroundColor: Colors.red[200]);
    });
  }

  Set<FavoriteItem> get listFavorite => _listFavorite;

  void removeFavoriteItem(final int id) {
    _loading(true);
    _appRepository.removeItemOfFavoriteList(id);
    _loading(false);
  }
}
