import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../generated/l10n.dart';
import '../models/user_view_model.dart';
import '../repository/app_repository.dart';
import '../server/api_client.dart';

class LoginController extends GetxController {
  final AppRepository appRepository = AppRepository(ApiClient());
  RxBool validateUsername = false.obs;
  RxBool validatePassword = false.obs;
  RxBool obscureTextPassword = true.obs;
  RxBool loading = false.obs;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<User> login(
      {required final String userName, required final String password}) async {
    loading(true);
    User user = User();
    await appRepository.checkUserInfo(userName, password).then((final value) {
      loading(false);
      user = value;
    }).onError((final error, final stackTrace) {
      loading(false);
      Get.snackbar(S.of(Get.context!).Error, S.of(Get.context!).details_error);
    });
    loading(false);
    return user;
  }
}
