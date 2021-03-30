
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_booki_shop/models/User.dart';
import 'package:flutter_booki_shop/repository/AppRepository.dart';
import 'package:flutter_booki_shop/shareprefrence.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{

  RxBool _loading =false.obs;
  AppRepository _appRepository;
  User _user = User();
  Uint8List _imageUint8;
  File _imgeFile;


  RxBool get loading => _loading;

  @override
  void onInit() {
    // TODO: implement onInit
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
        print(_user.email);
        print(_user.userName);
        print(_user.role);
        print(_user.password);
        print(_user.id);
        _imageUint8 = base64Decode(_user.image);
      }).onError((error, stackTrace){
        _loading(false);
        Get.snackbar("خطا", "مشکلی پیش آمده است ");
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
      _imgeFile = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    _loading(false);
  }

  File get imgeFile => _imgeFile;



  saveUserData(User user){
   if(checkUserValues()){
     _appRepository.sendUserData(user);
   }
  }

  bool checkUserValues() {

   /* if(user.phone.length!=12){
      Get.snackbar("خطا", "شماره تلفن باید 12 رقم باشد ");
      return false;
    }*/
    return true;

  }


}