import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/profile_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/User.dart';
import 'package:flutter_booki_shop/shareprefrence.dart';
import 'package:flutter_booki_shop/views/login/login.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  List<String> _spinnerItems = ['فارسی', 'انگلیسی'];

  ProfileController _profileController = Get.put(ProfileController());
  TextEditingController phoneCtr =new TextEditingController();
  TextEditingController userNameCtr =new TextEditingController();
  TextEditingController passwordCtr =new TextEditingController();

  @override
  Widget build(BuildContext context) {
    setFirstValues();


    // TODO: implement build
    return Scaffold(
      appBar: _appBar(context),
      body: _scrollView(context),
    );
  }

  Widget _scrollView(BuildContext context) {
    return SingleChildScrollView(
      child:
          Obx((){
            if(_profileController.loading.value==true){
              return CircularProgressIndicator();
            }
            else{
              return  Column(
                children: <Widget>[
                  _userImage(context),
                  _phoneItem(),
                  _userNameItem(),
                  _passwordItem(),
                  _languageItem(),
                  _exitBtn(context)
                ],
              );
            }
          })


    );
  }


  Container _userImage(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: (){
                _profileController.openCamera();
              },
              child: SizedBox(
                height: 120.0,
                width: 120.0,
                child:
                Obx((){
                  if(_profileController.loading.value==true){
                    return CircularProgressIndicator();
                  }
                  else{
                    if(_profileController.imageUint8!=null){
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.memory(_profileController.imageUint8,));
                    }
                    else{
                      return CircleAvatar(child: Icon(Icons.camera_alt,size: 45.0,));
                    }
                  }
                }),

              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _exitBtn(BuildContext context) {
    return SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: ElevatedButton(onPressed: () {
            MySharePrefrence().clearShareprefrence();
            Get.offAll(()=>Login());
          }, child: Text("خروج ")),
        ));
  }

  Widget _languageItem() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.today),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('فارسی'),
        ),
        title: DropdownButton<String>(
          value: _spinnerItems[0],
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontFamily: 'Dana'),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String data) {
            //Get.updateLocale(Locale('en'));
          },
          items:
          _spinnerItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _passwordItem() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.lock),
        title: new TextField(
          controller: passwordCtr,
        ),
      ),
    );
  }

  Widget _userNameItem() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.supervisor_account_rounded),
        title: new TextFormField(
          controller: userNameCtr,
          decoration: new InputDecoration(
            hintText: '${_profileController.user.userName}',
          ),
        ),
      ),
    );
  }

  Widget _phoneItem() {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.phone),
        title: new TextField(
          controller: phoneCtr,
          decoration: new InputDecoration(
            hintText: '${_profileController.user.phone}',
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: new Text(
        S.of(context)
            .profile,
        style: TextStyle(
            fontFamily: 'Dana', color: Colors.black, fontSize: 17.0),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        IconButton(icon: Icon(Icons.save), onPressed: () {
          sendUserData();
          Get.back();
        }),
      ],
    );
  }

  void sendUserData() {
    User user = User();
    if(userNameCtr.text.isEmpty){
      user.userName = _profileController.user.userName;
    }else{
      user.userName = userNameCtr.text;
    }

    if(passwordCtr.text.isEmpty){
      user.password = _profileController.user.password;
    }
    else{
      user.password = passwordCtr.text;
    }
    if(phoneCtr.text.isEmpty){
      user.phone = _profileController.user.phone;
    }
    else{
      user.phone=phoneCtr.text;
    }
    user.id = _profileController.user.id;
    user.image =base64Encode(_profileController.imageUint8);
    user.email = _profileController.user.email;
    user.role = _profileController.user.role;
    _profileController.saveUserData(user);
  }

  void setFirstValues() {
    phoneCtr.text = _profileController.user.phone;
    userNameCtr.text = _profileController.user.userName;
    passwordCtr.text = _profileController.user.password;
  }
}
