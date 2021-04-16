
import 'package:adder_cart_shop/custom_adder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets('CustomAdder', (WidgetTester tester) async {
    await tester.pumpWidget(widget());
    expect(find.text('5'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.remove), findsOneWidget);

   expect(find.widgetWithIcon(CircleAvatar, Icons.add),findsOneWidget);
   expect(find.widgetWithIcon(CircleAvatar, Icons.remove),findsOneWidget);


    await tester.tap(find.widgetWithIcon(CircleAvatar,Icons.add));
    await tester.pump();
    expect(find.text('6'), findsOneWidget);
    await tester.tap(find.widgetWithIcon(CircleAvatar,Icons.remove));
    await tester.pump();
    expect(find.text('5'), findsOneWidget);


    for(int i=0;i<5;i++){
     await tester.tap(find.widgetWithIcon(CircleAvatar,Icons.add));
      await tester.pump();
    }
    expect(find.text('10'), findsOneWidget);

    for(int i=0;i<4;i++){
      await tester.tap(find.widgetWithIcon(CircleAvatar,Icons.remove));
      await tester.pump();
    }
    expect(find.text('6'), findsOneWidget);



  });
}

Widget widget(){


  return MaterialApp(

    home: Scaffold(
      body: CustomAdder(value: 5,),
    ),
  );
}
