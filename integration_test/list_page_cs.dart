import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_lab/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('List Page Performance Test', () {
    final listPageFinder = find.byKey(const Key('List Page'));

    for (int i = 0; i < 10; i++) {
      testWidgets('Run ${i + 1}', (WidgetTester tester) async {
        // Clear the cache of the list_page
        tester.binding.pipelineOwner.flushLayout();
        tester.binding.pipelineOwner.flushSemantics();

        await tester
            .pumpWidget(const MyApp()); // Replace with your actual app widget.

        // Navigate to the List Page.
        await tester.tap(listPageFinder);
        await tester.pumpAndSettle();

        final listViewFinder = find.byType(ListView);

        // Autoscroll the list at medium speed for 20 seconds.
        const int steps = 10;
        const Offset scrollOffsetPerStep = Offset(0, -500);
        for (int step = 0; step < steps; step++) {
          await tester.drag(listViewFinder, scrollOffsetPerStep);
          await tester.pump(const Duration(milliseconds: 1000));
        }
        await tester.pumpAndSettle();

        // Go back to the home page.
        await tester.pageBack();
        await tester.pumpAndSettle();
      }, timeout: const Timeout(Duration(minutes: 3)));
    }
  });
}
