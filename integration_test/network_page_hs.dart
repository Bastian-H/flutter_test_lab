import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_lab/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Network Page Performance Test', () {
    final networkPageFinder = find.byKey(const Key('Network Page'));

    for (int i = 0; i < 10; i++) {
      testWidgets('Run ${i + 1}', (WidgetTester tester) async {
        await tester.pumpWidget(const MyApp());

        // Navigate to the Network Page.
        await tester.tap(networkPageFinder);
        await tester.pumpAndSettle();

        // Get the ListView and scroll it for 20 seconds.
        final listViewFinder = find.byType(ListView);
        const int steps = 20;
        const Duration delay = Duration(milliseconds: 200);
        for (int step = 0; step < steps; step++) {
          await tester.drag(listViewFinder, const Offset(0, -50));
          await tester.pump(delay);
        }
        await tester.pumpAndSettle();

        // Go back to the home page.
        await tester.pageBack();
        await tester.pumpAndSettle();
      }, timeout: const Timeout(Duration(minutes: 3)));
    }
  });
}
