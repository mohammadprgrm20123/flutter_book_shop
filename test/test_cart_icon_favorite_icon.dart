// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.



import 'package:flutter/material.dart';
import 'package:flutter_booki_shop/custom_widgets/card_icon_favorite_icon.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  testWidgets('AddFavoriteAndCartShop', (WidgetTester tester) async {
    await tester.pumpWidget(widget());

    expect(find.byIcon(Icons.add_shopping_cart_sharp),findsOneWidget);
    expect(find.byIcon(Icons.favorite),findsOneWidget);


   await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(find.byIcon(Icons.favorite_border),findsOneWidget);


    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(find.byIcon(Icons.favorite),findsOneWidget);


    await tester.tap(find.byIcon(Icons.add_shopping_cart_sharp,));
    await tester.pump();
    expect(find.byIcon(Icons.add_shopping_cart_sharp),findsOneWidget);


    


  });
}

Widget widget() {

  return MaterialApp(
    home: Scaffold(
      body: AddFavoriteAndCartShop(changeValueCartShop: (value){},changeValueFavorite: (value){},isFavorite: true,isCartShop: true,),
    ),
  );
}



