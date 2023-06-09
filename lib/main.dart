import 'package:flutter/gestures.dart';
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
 const MaterialColor yellow = MaterialColor(
   0xFFF9A825,
  <int, Color>{
    50: Color(0xFFFFFDE7),
    100: Color(0xFFFFF9C4),
    200: Color(0xFFFFF59D),
    300: Color(0xFFFFF176),
    400: Color(0xFFFFEE58),
    500: Color(0xFFFFEB3B),
    600: Color(0xFFFDD835),
    700: Color(0xFFFBC02D),
    800: Color(0xFFF9A825),
    900: Color(0xFFF57F17),
  },
);
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
    addPage();
    return GetMaterialApp(
      getPages: appPages,
      debugShowCheckedModeBanner: false,
      theme: _theme(),
      initialRoute: AppRoutes.homePage,
      localizationsDelegates: _(),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown},
      ),      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('fa'),
    );
  }

  List<LocalizationsDelegate<dynamic>> _() => const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];

  ThemeData _theme() => ThemeData(
      fontFamily: 'Dana',
      primarySwatch: yellow,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    primaryColor: const Color(0xFFF9A825),
    );

  void addPage() {
    appPages.add(GetPage(
        name: AppRoutes.homePage,
        page: () => HomePage(),
        middlewares: [MiddleWareLogin(role: role)]));
  }
}
