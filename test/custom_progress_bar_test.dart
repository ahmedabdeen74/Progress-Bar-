import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reward_progress_bar/reward_progress_bar.dart';

void main() {
  testWidgets('CustomProgressBar aligns LTR under LTR and RTL under RTL context', (WidgetTester tester) async {
    // 1. Test LTR context
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
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

    var startLabelFinder = find.text('Start');
    var endLabelFinder = find.text('End');

    expect(startLabelFinder, findsOneWidget);
    expect(endLabelFinder, findsOneWidget);

    double startX = tester.getCenter(startLabelFinder).dx;
    double endX = tester.getCenter(endLabelFinder).dx;

    expect(startX < endX, isTrue, reason: 'In LTR, Start milestone must be to the left of the End milestone');

    // 2. Test RTL context
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

    startLabelFinder = find.text('Start');
    endLabelFinder = find.text('End');

    startX = tester.getCenter(startLabelFinder).dx;
    endX = tester.getCenter(endLabelFinder).dx;

    expect(startX > endX, isTrue, reason: 'In RTL, Start milestone must be to the right of the End milestone');
  });
}
