import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/profile_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/models/User.dart';
import 'package:flutter_booki_shop/shareprefrence.dart';
import 'package:flutter_booki_shop/views/login/login.dart';
import 'package:get/get.dart';


class Profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return StateProfile();
  }

}


@immutable
class StateProfile extends State<Profile> {
  List<String> _spinnerItems = [S.of(Get.context).persion, S.of(Get.context).English];

  ProfileController _profileController = Get.put(ProfileController());
  TextEditingController _phoneCtr =new TextEditingController();
  TextEditingController _userNameCtr =new TextEditingController();
  TextEditingController _passwordCtr =new TextEditingController();

  @override
  Widget build(BuildContext context) {
    setFirstValues();
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
                children: _childrenColumn(context),
              );
            }
          })


    );
  }

  List<Widget> _childrenColumn(BuildContext context) {
    return <Widget>[
                _userImage(context),
                _phoneItem(),
                _userNameItem(),
                _passwordItem(),
                _languageItem(),
                _exitBtn(context)
              ];
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
              child: _image(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _image() {
    return SizedBox(
              height: 120.0,
              width: 120.0,
              child:
              _loadUserImage(),
            );
  }

  Widget _loadUserImage() {
    return Obx((){
                if(_profileController.loading.value==true){
                  return CircularProgressIndicator();
                }
                else{
                  if (_profileController.imageUnit8 != null) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.memory(
                _profileController.imageUnit8,
              ));
        } else {
          return CircleAvatar(
              child: Icon(
            Icons.camera_alt,
            size: 45.0,
          ));
        }
      }
              });
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
          }, child: Text(S.of(Get.context).Exit)),
        ));
  }

  Widget _languageItem() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.today),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(S.of(Get.context).persion),
        ),
        title: _dropdownButton(),
      ),
    );
  }

  Obx _dropdownButton() {
    return
      Obx((){
      return  DropdownButton<String>(
          value: _spinnerItems[_profileController.indexLanguageActive.value],
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontFamily: S.of(Get.context).name_font_dana),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String data) {
            if(data==S.of(Get.context).English){
              var locale = Locale('en', 'US');
              Get.updateLocale(locale);
              _profileController.indexLanguageActive(1);
            }
            else{
              var locale = Locale('fa', 'IR');
              Get.updateLocale(locale);
              _profileController.indexLanguageActive(0);
            }
          },
          items: itemsSpinner(),
        );

      });
  }

  List<DropdownMenuItem<String>> itemsSpinner() {
    return _spinnerItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList();
  }

  Widget _passwordItem() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.lock),
        title: new TextField(
          controller: _passwordCtr,
          decoration: new InputDecoration(
            hintText: '${_profileController.user.password}',
          ),
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
          controller: _userNameCtr,
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
          controller: _phoneCtr,
          decoration: new InputDecoration(
            hintText: '${_profileController.user.phone}',
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: _title(context),
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

  Text _title(BuildContext context) {
    return new Text(
      S.of(context)
          .profile,
      style: TextStyle(
          fontFamily: S.of(Get.context).name_font_dana, color: Colors.black, fontSize: 17.0),
    );
  }

  void sendUserData() {
    User user = _getUserData();
    _profileController.sendUserData(user);
  }

  User _getUserData() {
    User user = User();
    if (_userNameCtr.text.isEmpty)
      user.userName = _profileController.user.userName;
    else
      user.userName = _userNameCtr.text;
    if (_passwordCtr.text.isEmpty)
      user.password = _profileController.user.password;
    else
      user.password = _passwordCtr.text;
    if (_phoneCtr.text.isEmpty)
      user.phone = _profileController.user.phone;
    else
      user.phone = _phoneCtr.text;
    user.id = _profileController.user.id;
    user.image = base64Encode(_profileController.imageUnit8);
    user.email = _profileController.user.email;
    user.role = _profileController.user.role;
    return user;
  }

  void setFirstValues() {
    _phoneCtr.text = _profileController.user.phone;
    _userNameCtr.text = _profileController.user.userName;
    _passwordCtr.text = _profileController.user.password;
  }
}
