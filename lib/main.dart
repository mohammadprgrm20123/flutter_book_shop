import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/controllers/main_controller.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/views/admin_home/admin_home.dart';
import 'package:flutter_booki_shop/views/login/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'views/user_home/user_home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MainController _mainController = Get.put(MainController());
  final List<Widget> _listPage = [Login(), UserHome(), AdminHome()];

  MyApp();

  @override
  Widget build(final BuildContext context) {
    _mainController.checkUserLogin();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Dana',
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        primarySwatch: Colors.blue,
      ),
      home: Obx(() {
        if (_mainController.loading.value == true) {
          return _loading();
        } else {
          return _listPage[_mainController.indexStartPage.value];
        }
      }),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('fa'),
    );
  }

  Scaffold _loading() => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
