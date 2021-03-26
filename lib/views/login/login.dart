import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
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
    throw
    UnimplementedError
    (
    );
  }

  Container _loginBody() {
    return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                _iconLogin(),
                _userName(),
            _password()
            ],
      ),
          );
  }

  Padding _password() {
    return Padding(padding: const EdgeInsets.all(20.0),
            child: ObxValue((data) {
                RxBool data =true.obs;
             return TextFormField (
                  obscureText: data.value,
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

  InputDecoration _passwordDecoration(RxBool data) {
    return InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: _onTapSuffixIcon(data),
                  border: OutlineInputBorder(),
                  labelText: 'رمز عبور ',
                  hintText: 'رمز عبور',
                  // counter: Text("1/8")
                );
  }

  GestureDetector _onTapSuffixIcon(RxBool data) {
    return GestureDetector(
                    onTap: (){
                      print(data.value);
                      if(data.value==true){
                        data(false);
                      }
                      else{
                        data(true);
                      }
                      print(data.value);

                    },
                    child: Icon(Icons.remove_red_eye_rounded));
  }

  Padding _userName() {
    return Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                 decoration: InputDecoration(
                     prefixIcon: Icon(Icons.account_circle),
                     border: OutlineInputBorder(),
                     labelText: 'نام کاربری',
                  hintText: 'نام کاربری'
            ),
          ),
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

}