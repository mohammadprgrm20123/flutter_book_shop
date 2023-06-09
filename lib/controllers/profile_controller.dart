import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../generated/l10n.dart';
import '../models/user_view_model.dart';
import '../repository/app_repository.dart';
import '../server/api_client.dart';
import '../shareprefrence.dart';

class ProfileController extends GetxController {
  RxBool loading = false.obs;
  final AppRepository _appRepository =AppRepository(ApiClient());
  User _user = User();
  Uint8List? _imageUnit8;
  File? _imageFile;

  RxInt indexLanguageActive = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getProfileInfo();
  }

  Uint8List? get imageUnit8 => _imageUnit8;

  void getProfileInfo() async {
    loading(true);
    await MyStorage().getId().then((final value) {
      _appRepository.getProfileInfo(value).then((final value) {
        loading(false);
        _user = value;
        _imageUnit8 = base64Decode(_user.image!);
      }).onError((final error, final stackTrace) {
        loading(false);
        Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).has_problem,
            backgroundColor: Colors.red[200]);
      });
    });
  }

  User get user => _user;

  void openCamera() async {
    loading(true);
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _imageUnit8 = File(pickedFile.path).readAsBytesSync();
      _imageFile = File(pickedFile.path);
    }
    loading(false);
  }

  File? get imageFile => _imageFile;

  void sendUserData(final User user) {
    _appRepository.updateUserInfo(user);
  }
}
