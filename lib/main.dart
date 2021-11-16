import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'generated/l10n.dart';
import 'infractructure/app_pages.dart';
import 'infractructure/middelware/middleware_lgin.dart';
import 'infractructure/my_routes.dart';
import 'shareprefrence.dart';
import 'views/home/home_page.dart';

String role = 'none';

void main() async {
  await GetStorage.init();

  await MyStorage().getRole().then((final value) {
    if(value!=null){
      role = value;
    }
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    appPages.add(GetPage(
        name: AppRoutes.homePage,
        page: () => HomePage(),
        middlewares: [MiddleWareLogin(role: role)]));

    return GetMaterialApp(
      getPages: appPages,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Dana',
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.homePage,
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
}
