import 'package:get/get.dart';

import '../generated/l10n.dart';
import '../models/user_view_model.dart';
import '../repository/app_repository.dart';

class LoginController extends GetxController {
  AppRepository appRepository;
  RxBool validateUsername = false.obs;
  RxBool validatePassword = false.obs;
  RxBool obscureTextPassword = true.obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    appRepository = AppRepository();
  }

  Future<User> checkUserInfo(
      final String userName, final String password) async {
    loading(true);
    User user;
    await appRepository.checkUserInfo(userName, password).then((final value) {
      loading(false);
      user = value;
    }).onError((final error, final stackTrace) {
      loading(false);
      Get.snackbar(S.of(Get.context).Error, S.of(Get.context).details_error);
    });
    loading(false);
    return user;
  }
}
