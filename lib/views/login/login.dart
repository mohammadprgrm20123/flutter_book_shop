import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_booki_shop/controllers/login_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/user_view_model.dart';
import 'package:flutter_booki_shop/shareprefrence.dart';
import 'package:flutter_booki_shop/views/admin_home/admin_home.dart';
import 'package:flutter_booki_shop/views/user_home/user_home.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateLogin();
}

class StateLogin extends State<LoginPage> {
  final TextEditingController _usernameCtr = TextEditingController();
  final TextEditingController _passwordCtr = TextEditingController();
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(final BuildContext context) => SafeArea(
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

  Widget _loginBody() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_iconLogin(), _userName(), _password(), loginBtn()],
      );

  Padding loginBtn() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
          height: 50.0,
          width: MediaQuery.of(Get.context).size.width,
          child: _elevatedButtonLogin()));

  Widget _elevatedButtonLogin() => ElevatedButton(
        onPressed: () async {
          _checkParameters();
        },
        child: Obx(() => _loginController.loading.value
            ? const CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            : Text(S.of(Get.context).enter)),
      );

  void _checkParameters() {
    if (!checkEmpty()) {
      _loginController
          .checkUserInfo(_usernameCtr.text, _passwordCtr.text)
          .then((final value) {
        saveValues(value);
        goTo(value.role);
      });
    }
  }

  Padding _password() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: ObxValue(
        (final data) {
          final bool data = _loginController.validatePassword.value;
          final bool obscureText = _loginController.obscureTextPassword.value;
          return _textFieldPassword(obscureText, data);
        },
        false.obs,
      ));

  TextField _textFieldPassword(final bool obscureText, final bool data) =>
      TextField(
        controller: _passwordCtr,
        obscureText: obscureText,
        decoration: _passwordDecoration(data),
        maxLength: 12,
        buildCounter: _biuldCounterPassword,
      );

  Widget _biuldCounterPassword(final BuildContext context,
          {final int currentLength,
          final int maxLength,
          final bool isFocused}) =>
      isFocused
          ? Text(
              '$currentLength/$maxLength',
              style: const TextStyle(
                fontSize: 14.0,
              ),
            )
          : null;

  InputDecoration _passwordDecoration(final bool data) => InputDecoration(
        errorText: data ? S.of(Get.context).please_fill_parameters : null,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: _onTapSuffixIcon(),
        border: const OutlineInputBorder(),
        labelText: S.of(Get.context).password,
        hintText: S.of(Get.context).password,
        // counter: Text("1/8")
      );

  GestureDetector _onTapSuffixIcon() => GestureDetector(
      onTap: () {
        if (_loginController.obscureTextPassword.value == true) {
          _loginController.obscureTextPassword(false);
        } else {
          _loginController.obscureTextPassword(true);
        }
      },
      child: const Icon(Icons.remove_red_eye_rounded));

  ObxValue<RxBool> _userName() => ObxValue(
        (final data) {
          final bool data = _loginController.validateUsername.value;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: _textFieldUserName(data),
          );
        },
        false.obs,
      );

  TextField _textFieldUserName(final bool data) => TextField(
        controller: _usernameCtr,
        decoration: _usernameDecoration(data),
      );

  InputDecoration _usernameDecoration(final bool data) => InputDecoration(
        errorText: data ? S.of(Get.context).please_fill_parameters : null,
        prefixIcon: const Icon(Icons.account_circle),
        border: const OutlineInputBorder(),
        labelText: S.of(Get.context).userName,
        hintText: S.of(Get.context).userName,
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
      const BoxDecoration(shape: BoxShape.circle, color: Colors.blue);

  bool checkEmpty() {
    if (_passwordCtr.text.isEmpty || _usernameCtr.text.isEmpty) {
      if (_passwordCtr.text.isEmpty) {
        _loginController.validatePassword(true);
      } else {
        _loginController.validatePassword(false);
      }
      if (_usernameCtr.text.isEmpty) {
        _loginController.validateUsername(true);
      } else {
        _loginController.validateUsername(false);
      }
      return true;
    }
    _loginController.validatePassword(false);
    _loginController.validateUsername(false);
    return false;
  }

  void saveValues(final User user) async {
    MyStorage().setId(user.id);
    MyStorage().setRole(user.role);
    MyStorage().setPassword(user.password);
    MyStorage().setUserName(user.userName);
    MyStorage().setPhone(user.phone);
  }

  void goTo(final String role) {
    if (role == S.of(Get.context).userRole) {
      Get.offAll(UserHomePage());
    } else {
      Get.offAll(AdminHomePage());
    }
  }
}
