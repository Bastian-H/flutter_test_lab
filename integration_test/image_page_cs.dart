import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_lab/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Image Page Performance Test', () {
    final imagePageFinder = find.byKey(const Key('Image Page'));

    for (int i = 0; i < 10; i++) {
      testWidgets('Run ${i + 1}', (WidgetTester tester) async {
        // Clear the cache of the list_page
        tester.binding.pipelineOwner.flushLayout();
        tester.binding.pipelineOwner.flushSemantics();
        await tester
            .pumpWidget(const MyApp()); // Replace with your actual app widget.

        // Navigate to the Image Page.
        await tester.tap(imagePageFinder);
        await tester.pumpAndSettle();

        final gridViewFinder = find.byType(GridView);

        // Autoscroll the grid view at a slow speed for 20 seconds.
        const int steps = 20;
        const Offset scrollOffsetPerStep = Offset(0, -50);
        for (int step = 0; step < steps; step++) {
          await tester.drag(gridViewFinder, scrollOffsetPerStep);
          await tester.pump(const Duration(milliseconds: 200));
        }
        await tester.pumpAndSettle();

        // Go back to the home page.
        await tester.pageBack();
        await tester.pumpAndSettle();
      }, timeout: const Timeout(Duration(minutes: 3)));
    }
  });
}
