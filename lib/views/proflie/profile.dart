import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';
import '../../generated/l10n.dart';
import '../../models/user_view_model.dart';
import '../../shareprefrence.dart';
import '../login/login.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateProfile();
}

class StateProfile extends State<Profile> {
  final List<String> _spinnerItems = [
    S.of(Get.context).persion,
    S.of(Get.context).English
  ];

  final ProfileController _profileController = Get.put(ProfileController());
  final TextEditingController _phoneCtr = TextEditingController();
  final TextEditingController _userNameCtr = TextEditingController();
  final TextEditingController _passwordCtr = TextEditingController();

  StateProfile() {
    setFirstValues();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: _appBar(context),
        body: _scrollView(context),
      );

  Widget _scrollView(final BuildContext context) =>
      SingleChildScrollView(child: Obx(() {
        if (_profileController.loading.value == true) {
          return const CircularProgressIndicator();
        } else {
          return Column(
            children: _childrenColumn(context),
          );
        }
      }));

  List<Widget> _childrenColumn(final BuildContext context) => <Widget>[
        _userImage(context),
        _phoneItem(),
        _userNameItem(),
        _passwordItem(),
        _languageItem(),
        _exitBtn(context)
      ];

  Widget _userImage(final BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                _profileController.openCamera();
              },
              child: _image(),
            ),
          ),
        ],
      );

  Widget _image() => SizedBox(
        height: 120.0,
        width: 120.0,
        child: _loadUserImage(),
      );

  Widget _loadUserImage() => Obx(() {
        if (_profileController.loading.value == true) {
          return const CircularProgressIndicator();
        } else {
          if (_profileController.imageUnit8 != null) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.memory(
                  _profileController.imageUnit8,
                ));
          } else {
            return const CircleAvatar(
                child: Icon(
              Icons.camera_alt,
              size: 45.0,
            ));
          }
        }
      });

  SizedBox _exitBtn(final BuildContext context) => SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: ElevatedButton(
            onPressed: () {
              MySharePrefrence().clearShareprefrence();
              Get.offAll(() => Login());
            },
            child: Text(S.of(Get.context).Exit)),
      ));

  Widget _languageItem() => Padding(
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

  Obx _dropdownButton() => Obx(() => DropdownButton<String>(
        value: _spinnerItems[_profileController.indexLanguageActive.value],
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: S.of(Get.context).name_font_dana),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (final data) {
          if (data == S.of(Get.context).English) {
            const Locale locale = Locale('en', 'US');
            Get.updateLocale(locale);
            _profileController.indexLanguageActive(1);
          } else {
            const locale = Locale('fa', 'IR');
            Get.updateLocale(locale);
            _profileController.indexLanguageActive(0);
          }
        },
        items: itemsSpinner(),
      ));

  List<DropdownMenuItem<String>> itemsSpinner() => _spinnerItems
      .map<DropdownMenuItem<String>>((final value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  Widget _passwordItem() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: const Icon(Icons.lock),
          title: TextField(
            controller: _passwordCtr,
            decoration: InputDecoration(
              hintText: _profileController.user.password,
            ),
          ),
        ),
      );

  Widget _userNameItem() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: const Icon(Icons.supervisor_account_rounded),
          title: TextFormField(
            controller: _userNameCtr,
            decoration: InputDecoration(
              hintText: _profileController.user.userName,
            ),
          ),
        ),
      );

  Widget _phoneItem() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: const Icon(Icons.phone),
          title: TextField(
            controller: _phoneCtr,
            decoration: InputDecoration(
              hintText: _profileController.user.phone,
            ),
          ),
        ),
      );

  AppBar _appBar(final BuildContext context) => AppBar(
        title: _title(context),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                sendUserData();
                Get.back();
              }),
        ],
      );

  Text _title(final BuildContext context) => Text(
        S.of(context).profile,
        style: TextStyle(
            fontFamily: S.of(Get.context).name_font_dana,
            color: Colors.black,
            fontSize: 17.0),
      );

  void sendUserData() {
    final User user = _getUserData();
    _profileController.sendUserData(user);
  }

  User _getUserData() {
    final User user = User();
    if (_userNameCtr.text.isEmpty) {
      user.userName = _profileController.user.userName;
    } else {
      user.userName = _userNameCtr.text;
    }
    if (_passwordCtr.text.isEmpty) {
      user.password = _profileController.user.password;
    } else {
      user.password = _passwordCtr.text;
    }
    if (_phoneCtr.text.isEmpty) {
      user.phone = _profileController.user.phone;
    } else {
      user.phone = _phoneCtr.text;
    }
    user
      ..id = _profileController.user.id
      ..image = base64Encode(_profileController.imageUnit8)
      ..email = _profileController.user.email
      ..role = _profileController.user.role;
    return user;
  }

  void setFirstValues() {
    _phoneCtr.text = _profileController.user.phone;
    _userNameCtr.text = _profileController.user.userName;
    _passwordCtr.text = _profileController.user.password;
  }
}
