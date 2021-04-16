import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tag_editor/tag_editor.dart';

void main() {
  testWidgets('TagEditor', (WidgetTester tester) async {
    await tester.pumpWidget(widget());

    expect(find.widgetWithIcon(ElevatedButton, Icons.add), findsOneWidget);
    expect(find.text("تگ"), findsNWidgets(2));

    await tester.enterText(find.widgetWithText(TextFormField, 'تگ'), "4545");

    await tester.tap(find.widgetWithIcon(ElevatedButton, Icons.add));
    await tester.pump();

    expect(find.widgetWithIcon(Row, Icons.remove_circle_sharp), findsWidgets);

    expect(find.byIcon(Icons.remove_circle_sharp), findsWidgets);
  });
}

Widget widget() {
  List<String> list = ['tag1', 'tag2', 'tag3', 'tag4', 'tag6', 'tag7'];

  return MaterialApp(
    home: Scaffold(
      body: TagEditor(
        firstValueListTag: list,
        addTags: (tag) {},
        removeTags: (tag) {},
      ),
    ),
  );
}