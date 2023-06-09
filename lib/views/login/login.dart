import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../generated/l10n.dart';
import '../../models/user_view_model.dart';
import '../../shareprefrence.dart';
import '../admin_home/admin_home.dart';
import '../management_user_home.dart';
import '../shared/widgets/my_buton.dart';
import '../user_home/user_home.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(final BuildContext context) => safeArea();

  SafeArea safeArea() => SafeArea(
        top: true,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: _loginBody(),
            ),
          ),
        ),
      );

  Widget _loginBody() => form();

  Widget form() => Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _iconLogin(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: _userName(),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: _password(),
            ),
            _elevatedButtonLogin()
          ],
        ),
      );

  Widget _elevatedButtonLogin() => Obx(() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: MyButton(
          onTap: () {
            if (controller.formKey.currentState!.validate()) {
              login();
            }
          },
          label: 'ورود',
          loading: controller.loading.value,
        ),
      ));

  void login() {
    controller
        .login(
            userName: controller.usernameController.text,
            password: controller.passwordController.text)
        .then((final value) {
      saveValues(value);
      goTo(value.role!);
    });
  }

  Widget _password() => _textFieldPassword();

  Widget _textFieldPassword() => ObxValue<RxBool>(
      (final show) => TextFormField(
            validator: _validate,
            obscureText: show.value,
            obscuringCharacter: '*',
            controller: controller.passwordController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: GestureDetector(
                  onTap: (){
                    show.value =!show.value;
                  },
                  child: const Icon(Icons.ten_k)),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF9A825))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF9A825))),
              labelText: S.of(Get.context!).password,
              hintText: S.of(Get.context!).password,
              // counter: Text("1/8")
            ),
            maxLength: 12,
          ),
      false.obs);

  Text? _buildCounterPassword(final BuildContext context,
          {required final int currentLength,
          required final int maxLength,
          required final bool isFocused}) =>
      isFocused
          ? Text(
              '$currentLength/$maxLength',
              style: const TextStyle(
                fontSize: 14.0,
              ),
            )
          : null;

  Widget _userName() => _textFieldUserName();

  Widget _textFieldUserName() => TextFormField(
        controller: controller.usernameController,
        validator: _validate,
        decoration: _usernameDecoration(),
      );

  String? _validate(final String? value) {
    if (value!=null && value.isEmpty) {
      return 'این فیلد دنباید خالی باشد';
    }
    return null;
  }

  InputDecoration _usernameDecoration() => InputDecoration(
        prefixIcon: const Icon(Icons.account_circle),
        border: const OutlineInputBorder(),
        labelText: S.of(Get.context!).userName,
        hintText: S.of(Get.context!).userName,
      );

  Widget _iconLogin() => Container(
        decoration: _boxDecorationIconLogin(),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Icon(
            Icons.login,
            size: 40.0,
            color: Colors.white,
          ),
        ),
      );

  BoxDecoration _boxDecorationIconLogin() =>
      const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF9A825));

  void saveValues(final User user) async {
    MyStorage().setId(user.id!);
    MyStorage().setRole(user.role!);
    MyStorage().setPassword(user.password!);
    MyStorage().setUserName(user.userName!);
    MyStorage().setPhone(user.phone!);
  }

  void goTo(final String role) {
    if (role == S.of(Get.context!).userRole) {
      Get.offAll(ManagementUserHome());
    } else {
      Get.offAll(AdminHomePage());
    }
  }
}
