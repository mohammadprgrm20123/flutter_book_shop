import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/login_controller.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  TextEditingController _usernameCtr = new TextEditingController();
  TextEditingController _passwordCtr = new TextEditingController();

  LoginController _loginController =Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return SafeArea(
      top: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:30.0),
            child: _loginBody(),
          ),
      ),),
    );
  }

  Container _loginBody() {
    return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                _iconLogin(),
                _userName(),
                _password(),
                loginBtn()
            ],
      ),
          );
  }

  Padding loginBtn() {
    return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    height: 50.0,
                    width: MediaQuery.of(Get.context).size.width,
                    child: ElevatedButton(onPressed: (){

                      if(!checkEmpty()){

                      }



                    }, child: Text("ورود"))),
              );
  }

  Padding _password() {
    return Padding(padding: const EdgeInsets.all(20.0),
            child: ObxValue((data) {
                bool data =_loginController.validatePasswrod.value;
                bool obscureText = _loginController.obscureText.value;
                print(data.toString()+"password---------------------------------------------");
             return TextFormField (
               controller: _passwordCtr,
                  obscureText: obscureText,
                  decoration: _passwordDecoration(data),
                  maxLength: 10,
                  buildCounter: _biuldCounterPassword,
                );
              },
              false.obs,
            )
          );
  }

  Widget _biuldCounterPassword(BuildContext context,
           {int currentLength, int maxLength, bool isFocused}) {
         return isFocused
             ? Text(
           '$currentLength/$maxLength ',
           style: new TextStyle(
             fontSize: 14.0,
           ),
           semanticsLabel: 'Input constraints',
         )
             : null;
       }

  InputDecoration _passwordDecoration(bool data) {
    return InputDecoration(
                  errorText: data? 'لطفا مقادیر را پر کنید':null,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: _onTapSuffixIcon(),
                  border: OutlineInputBorder(),
                  labelText: 'رمز عبور ',
                  hintText: 'رمز عبور',
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
      print(data.toString()+"username-----------------------------------------------");

      return  Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          controller: _usernameCtr,
          decoration: _usernameDecoration(data),
        ),
      );
    },
      false.obs,
    );
  }

  InputDecoration _usernameDecoration(bool data) {
    return InputDecoration(
            errorText: data? 'لطفا مقادیر را پر کنید':null,
            prefixIcon: Icon(Icons.account_circle),
            border: OutlineInputBorder(),
            labelText: 'نام کاربری',
            hintText: 'نام کاربری'
        );
  }

  Container _iconLogin() {
    return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.login,size: 40.0,color: Colors.white,),
                ),
              );
  }

  bool checkEmpty() {
    print(_passwordCtr.text+"passssssss");
    print(_usernameCtr.text+"userrrrrrrr");
    if(_passwordCtr.text.isEmpty || _usernameCtr.text.isEmpty){
      if(_passwordCtr.text.isEmpty) _loginController.validatePasswrod(true);
      else _loginController.validatePasswrod(false);


      if(_usernameCtr.text.isEmpty) _loginController.validateUsername(true);
      else _loginController.validateUsername(false);

    return true;
    }
    _loginController.validatePasswrod(false);
    _loginController.validateUsername(false);
    return false;
  }

}