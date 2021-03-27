import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/main_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/views/admin/admin_home.dart';
import 'package:flutter_booki_shop/views/login/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'views/home/user_home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  List<Widget> _listPage = [
    Login(),
    UserHome(),
    AdminHome()
  ];
  MainController _mainController =Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    _mainController.checkUserLogin();
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Dana',
         iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
        primarySwatch: Colors.blue,
      ),
      home: Obx((){
        Widget page = _listPage[_mainController.indexStartPage.value];
        return page;
      }),
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale('fa'),
    );
  }




}
