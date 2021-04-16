

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_booki_shop/controllers/login_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/User.dart';
import 'package:flutter_booki_shop/shareprefrence.dart';
import 'package:flutter_booki_shop/views/admin_home/admin_home.dart';
import 'package:flutter_booki_shop/views/user_home/user_home.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StateLogin();
  }
}




class StateLogin extends State<Login> {
  TextEditingController _usernameCtr=new TextEditingController();
  TextEditingController _passwordCtr=new TextEditingController();
  LoginController _loginController =Get.put(LoginController());

  @override
  Widget build(BuildContext context) {

    return SafeArea(
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
  }

  Widget _loginBody() {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_iconLogin(), _userName(), _password(), loginBtn()],
          ),
        );
  }

  Padding loginBtn() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
          height: 50.0,
          width: MediaQuery.of(Get.context).size.width,
          child: _elevatedButtonLogin()
    ));
  }

  Widget _elevatedButtonLogin() {
    return ElevatedButton(
            onPressed: () async {
              _checkParameters();
            },
            child: Obx(()=>_loginController.loading.value? CircularProgressIndicator(backgroundColor: Colors.white,):Text(S.of(Get.context).enter)),
            );
  }

  void _checkParameters() {
     if (!checkEmpty()) {
      _loginController
          .checkUserInfo(_usernameCtr.text, _passwordCtr.text)
          .then((value) {
            saveValues(value);
            goTo(value.role);
      });
    }
  }

  Padding _password() {
    return Padding(padding: const EdgeInsets.all(20.0),
            child: ObxValue((data) {
                bool data =_loginController.validatePassword.value;
                bool obscureText = _loginController.obscureText.value;
             return _textFieldPassword(obscureText, data);
              },
              false.obs,
            )
          );
  }

  TextField _textFieldPassword(bool obscureText, bool data) {
    return TextField (
             controller: _passwordCtr,
             obscureText: obscureText,
             decoration: _passwordDecoration(data),
             maxLength: 12,
             buildCounter: _biuldCounterPassword,
          );
  }

  Widget _biuldCounterPassword(BuildContext context,{int currentLength, int maxLength, bool isFocused}) {
         return isFocused
             ? Text(
           '$currentLength/$maxLength',
           style: new TextStyle(
             fontSize: 14.0,
           ),
         )
             : null;
       }

  InputDecoration _passwordDecoration(bool data) {
    return InputDecoration(
                  errorText: data? S.of(Get.context).please_fill_parameters:null,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: _onTapSuffixIcon(),
                  border: OutlineInputBorder(),
                  labelText: S.of(Get.context).password,
                  hintText: S.of(Get.context).password,
                  // counter: Text("1/8")
                );
  }

  GestureDetector _onTapSuffixIcon() {
    return GestureDetector(
                    onTap: (){
                    if(_loginController.obscureText.value==true){
                      _loginController.obscureText(false);
                    }
                    else{
                      _loginController.obscureText(true);
                    }
                    },
                    child: Icon(Icons.remove_red_eye_rounded));
  }

  ObxValue<RxBool> _userName() {
   return  ObxValue((data) {
      bool data =_loginController.validateUsername.value;
      return  Padding(
        padding: const EdgeInsets.all(20.0),
        child: _textFieldUserName(data),
      );
    },
      false.obs,
    );
  }

  TextField _textFieldUserName(bool data) {
    return TextField(
      key: Key("textFieldUserName"),
        controller: _usernameCtr,
        decoration: _usernameDecoration(data),
      );
  }

  InputDecoration _usernameDecoration(bool data) {
    return InputDecoration(
            errorText: data? S.of(Get.context).please_fill_parameters:null,
            prefixIcon: Icon(Icons.account_circle),
            border: OutlineInputBorder(),
            labelText: S.of(Get.context).userName,
            hintText: S.of(Get.context).userName,
        );
  }

  Widget _iconLogin() {
    return Container(
                decoration: _boxDecorationIconLogin(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.login,size: 40.0,color: Colors.white,),
                ),
              );
  }

  BoxDecoration _boxDecorationIconLogin() {
    return BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue
              );
  }

  bool checkEmpty() {
    if(_passwordCtr.text.isEmpty || _usernameCtr.text.isEmpty){
      if(_passwordCtr.text.isEmpty) _loginController.validatePassword(true);

      else _loginController.validatePassword(false);
      if(_usernameCtr.text.isEmpty) _loginController.validateUsername(true);

      else _loginController.validateUsername(false);
    return true;
    }
    _loginController.validatePassword(false);
    _loginController.validateUsername(false);
    return false;
  }

  void saveValues(User user) async {
  MySharePrefrence().setId(user.id);
  MySharePrefrence().setRole(user.role);
  MySharePrefrence().setPassword(user.password);
  MySharePrefrence().setUserName(user.userName);
  MySharePrefrence().setPhone(user.phone);
  }

  void goTo(String role) {
    if(role==S.of(Get.context).userRole){
      Get.offAll(UserHome());
    }
    else{
      Get.offAll(AdminHome());
    }
  }

}