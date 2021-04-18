import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/User.dart';
import 'package:flutter_booki_shop/repository/app_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  AppRepository _appRepository;
  RxBool _validateUsername = false.obs;
  RxBool _validatePassword = false.obs;
  RxBool _obscureTextPassword = true.obs;
  RxBool _loading = false.obs;

  RxBool get loading => _loading;

  RxBool get obscureText => _obscureTextPassword;

  @override
  void onInit() {
    super.onInit();
    _appRepository = AppRepository();
  }

  RxBool get validateUsername => _validateUsername;

  Future<User> checkUserInfo(String userName, String password) async {
    _loading(true);
    User user;
    await _appRepository.checkUserInfo(userName, password).then((value) {
      _loading(false);
      user = value;
    }).onError((error, stackTrace) {
      _loading(false);
      Get.snackbar(S.of(Get.context).Error, S.of(Get.context).details_error);
    });
    _loading(false);
    return user;
  }

  RxBool get validatePassword => _validatePassword;
}