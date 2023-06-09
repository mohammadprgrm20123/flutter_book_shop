import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';
import '../../generated/l10n.dart';
import '../../models/user_view_model.dart';
import '../../shareprefrence.dart';
import '../login/login.dart';

class Profile extends GetView<ProfileController> {

  @override
  Widget build(final BuildContext context) {
    Get.lazyPut(() => ProfileController());

    return Scaffold(
      appBar: _appBar(context),
      body: _scrollView(context),
    );
  }
    Widget _scrollView(final BuildContext context) =>
        SingleChildScrollView(child: Obx(() {
          if (controller.loading.value == true) {
            return const CircularProgressIndicator();
          } else {
            return controller.user.value!=null ? Column(
              children: _childrenColumn(context),
            ) : const Center(child: Text('No Data'),);
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
              controller.openCamera();
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
      if (controller.loading.value == true) {
        return const CircularProgressIndicator();
      } else {
        if (controller.imageUnit8 != null) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.memory(
                controller.imageUnit8!,
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
                MyStorage().clearShareprefrence();
                Get.offAll(() => LoginPage());
              },
              child: Text(S.of(Get.context!).Exit)),
        ));

    Widget _languageItem() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.today),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(S.of(Get.context!).persion),
        ),
        title: _dropdownButton(),
      ),
    );

    Obx _dropdownButton() => Obx(() => DropdownButton<String>(
      value: controller.spinnerItems[controller.indexLanguageActive.value],
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: S.of(Get.context!).name_font_dana),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (final data) {
        if (data == S.of(Get.context!).English) {
          const Locale locale = Locale('en', 'US');
          Get.updateLocale(locale);
          controller.indexLanguageActive(1);
        } else {
          const locale = Locale('fa', 'IR');
          Get.updateLocale(locale);
          controller.indexLanguageActive(0);
        }
      },
      items: itemsSpinner(),
    ));

    List<DropdownMenuItem<String>> itemsSpinner() => controller.spinnerItems
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
          controller: controller.passwordCtr,
          decoration: InputDecoration(
            hintText: controller.user.value!.password,
          ),
        ),
      ),
    );

    Widget _userNameItem() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.supervisor_account_rounded),
        title: TextFormField(
          controller: controller.userNameCtr,
          decoration: InputDecoration(
            hintText: controller.user.value!.userName,
          ),
        ),
      ),
    );

    Widget _phoneItem() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.phone),
        title: TextField(
          controller: controller.phoneCtr,
          decoration: InputDecoration(
            hintText: controller.user.value!.phone,
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
          fontFamily: S.of(Get.context!).name_font_dana,
          color: Colors.black,
          fontSize: 17.0),
    );

    void sendUserData() {
      final User user = _getUserData();
      controller.sendUserData(user);
    }

    User _getUserData() {
      final User user = User();
      if (controller.userNameCtr.text.isEmpty) {
        user.userName = controller.user.value!.userName;
      } else {
        user.userName = controller.userNameCtr.text;
      }
      if (controller.passwordCtr.text.isEmpty) {
        user.password = controller.user.value!.password;
      } else {
        user.password = controller.passwordCtr.text;
      }
      if (controller.phoneCtr.text.isEmpty) {
        user.phone = controller.user.value!.phone;
      } else {
        user.phone = controller.phoneCtr.text;
      }
      user
        ..id = controller.user.value!.id
        ..image = base64Encode(controller.imageUnit8!)
        ..email = controller.user.value!.email
        ..role = controller.user.value!.role;
      return user;
    }

    void setFirstValues() {
     controller.phoneCtr.text = controller.user.value!.phone!;
     controller.userNameCtr.text = controller.user.value!.userName!;
     controller.passwordCtr.text = controller.user.value!.password!;
    }

}
