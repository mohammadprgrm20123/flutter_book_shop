
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/User.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:flutter_booki_shop/shareprefrence.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{

  RxBool _loading = false.obs;
  AppRepository _appRepository;
  User _user = User();
  Uint8List _imageUnit8;
  File _imageFile;

  RxBool get loading => _loading;
  RxInt indexLanguageActive = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _appRepository = new AppRepository();
    getProfileInfo();
  }

  Uint8List get imageUnit8 => _imageUnit8;

  getProfileInfo() async {
    _loading(true);
    MySharePrefrence().getId().then((value) {
      _appRepository.getProfileInfo(value).then((value) {
        _loading(false);
        _user = value;
        _imageUnit8 = base64Decode(_user.image);
      }).onError((error, stackTrace) {
        _loading(false);
        Get.snackbar(S.of(Get.context).error, S.of(Get.context).has_problem,
            backgroundColor: Colors.red[200]);
      });
    });
  }

  User get user => _user;
  openCamera() async {
    _loading(true);
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _imageUnit8 = File(pickedFile.path).readAsBytesSync();
      _imageFile = File(pickedFile.path);
    }
    _loading(false);
  }

  File get imageFile => _imageFile;
  sendUserData(User user){
     _appRepository.updateUserInfo(user);
   }
}