import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_lab/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Animation Page Performance Test', () {
    final animationPageFinder = find.byKey(const Key('Animation Page'));

    testWidgets('Animation Performance Test', (WidgetTester tester) async {
      // Open the Animation Page.
      await tester.pumpWidget(const MyApp());
      await tester.tap(animationPageFinder);
      await tester.pumpAndSettle();

      // Wait for 1 minute.
      await tester.pump(const Duration(seconds: 20));

      // Close the Animation Page.
      Navigator.of(tester.element(find.byType(Scaffold))).pop();
      await tester.pumpAndSettle();
    }, timeout: const Timeout(Duration(seconds: 20)));
  });
}
