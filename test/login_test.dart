// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.



import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/custom_widgets/card_icon_favorite_icon.dart';
import 'package:flutter_booki_shop/generated/l10n.dart';
import 'package:flutter_booki_shop/views/login/login.dart';
import 'package:flutter_booki_shop/views/user_home/user_home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';


void main() {

  testWidgets('Login', (WidgetTester tester) async {
    await tester.pumpWidget(widget());

    //expect(find.byType(ElevatedButton),findsOneWidget);
    //expect(find.widgetWithIcon(TextField, Icons.account_circle),findsOneWidget);
    //expect(find.byType(ElevatedButton),findsOneWidget);

  });
}

Widget widget() {

  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Dana',
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      primarySwatch: Colors.blue,
    ),
    home: Scaffold(body: Login(),),
    localizationsDelegates: [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    locale: Locale('fa'),
  );

}



