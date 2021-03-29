import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/profile_controller.dart';
import 'package:flutter_booki_shop/custom_widgets/custom_bottomNavigation.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/shareprefrence.dart';
import 'package:flutter_booki_shop/views/login/login.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  List<String> _spinnerItems = ['فارسی', 'انگلیسی'];

  ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
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

      height: 200.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 120.0,
              width: 120.0,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://imgcdn.taaghche.com/frontCover/90938.jpg?w=200",
                    scale: 10.0),
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

  ListTile _languageItem() {
    return ListTile(
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
    );
  }

  ListTile _passwordItem() {
    return ListTile(
      leading: const Icon(Icons.lock),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('***********'),
      ),
      title: new TextField(
        decoration: new InputDecoration(
          hintText: "رمز عبور ",
        ),
      ),
    );
  }

  ListTile _userNameItem() {
    return ListTile(
      leading: const Icon(Icons.supervisor_account_rounded),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('${_profileController.user.userName}'),
      ),
      title: new TextFormField(
        decoration: new InputDecoration(
          hintText: "نام کاربری",
        ),
      ),
    );
  }

  ListTile _phoneItem() {

    return ListTile(
      leading: const Icon(Icons.phone),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('${_profileController.user.phone}'),
      ),
      title: new TextField(
        decoration: new InputDecoration(
          hintText: "شماره تلفن",
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: new Text(
        S
            .of(context)
            .profile,
        style: TextStyle(
            fontFamily: 'Dana', color: Colors.black, fontSize: 17.0),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        IconButton(icon: Icon(Icons.save), onPressed: () {}),
      ],
    );
  }
}
