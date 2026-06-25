import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reward_progress_bar/reward_progress_bar.dart';

void main() {
  testWidgets('CustomProgressBar remains LTR even in RTL environment', (WidgetTester tester) async {
    // Build the widget inside an RTL Directionality context.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: CustomProgressBar(
                currentPoints: 20,
                milestones: const [0, 50, 100],
                labels: const ['Start', 'Middle', 'End'],
              ),
            ),
          ),
        ),
      ),
    );

    // Find the labels.
    final startLabelFinder = find.text('Start');
    final endLabelFinder = find.text('End');

    expect(startLabelFinder, findsOneWidget);
    expect(endLabelFinder, findsOneWidget);

    final double startX = tester.getCenter(startLabelFinder).dx;
    final double endX = tester.getCenter(endLabelFinder).dx;

    // In a normal LTR layout, the start milestone (index 0) is on the left (smaller X),
    // and the end milestone is on the right (larger X).
    // If the widget did not force LTR and fell back to the RTL context,
    // startX would be greater than endX.
    expect(startX < endX, isTrue, reason: 'Start milestone must be to the left of the End milestone');
  });
}
