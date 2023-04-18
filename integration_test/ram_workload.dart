import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_lab/pages/home_page.dart';

void main() {
  testWidgets('RAM workload test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Tap the RAM Workload button 10 times.
    for (var i = 0; i < 10; i++) {
      await tester.tap(find.byKey(const Key('RAM Workload')));
      await tester.pumpAndSettle(const Duration(seconds: 10));
    }
  });
}
