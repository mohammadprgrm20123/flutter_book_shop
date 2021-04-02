
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

  RxBool _loading =false.obs;
  AppRepository _appRepository;
  User _user = User();
  Uint8List _imageUint8;
  File _imageFile;
  RxBool get loading => _loading;
  RxInt indexLanguageActive =0.obs;

  @override
  void onInit() {
    super.onInit();
    _appRepository = new AppRepository();
    getUserProfile();
  }


  Uint8List get imageUint8 => _imageUint8;

  getUserProfile() async{
    _loading(true);
    MySharePrefrence().getId().then((value) {
      _appRepository.getUserProfile(value).then((value) {
        _loading(false);
        _user = value;
        _imageUint8 = base64Decode(_user.image);
      }).onError((error, stackTrace){
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
      _imageUint8 =File(pickedFile.path).readAsBytesSync();
      _imageFile = File(pickedFile.path);
    }
    _loading(false);
  }

  File get imgeFile => _imageFile;

  sendUserData(User user){
     _appRepository.updateUserData(user);
   }
}