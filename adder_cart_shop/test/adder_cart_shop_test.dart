
import 'package:adder_cart_shop/custom_adder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets('CustomAdder', (WidgetTester tester) async {
    await tester.pumpWidget(CustomAdder(value: 5,));
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

  });
}
