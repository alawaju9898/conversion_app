// This is a basic Flutter widget test for the ConverterApp.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:conversion_app/main.dart';

void main() {
  testWidgets('Conversion functionality test', (WidgetTester tester) async {
    // Build the ConverterApp and trigger a frame.
    await tester.pumpWidget(const ConverterApp());

    // Find the TextField and enter a test value, for example, '1'.
    final textFieldFinder = find.byType(TextField);
    await tester.enterText(textFieldFinder, '1');

    // Find and select a unit in the 'From' dropdown (e.g., kilometers).
    await tester.tap(find.text('kilometers'));
    await tester.pumpAndSettle(); // Wait for the dropdown to open and settle.
    await tester.tap(find.text('kilometers').last);
    await tester.pumpAndSettle(); // Wait for the dropdown to close.

    // Find and select a unit in the 'To' dropdown (e.g., miles).
    await tester.tap(find.text('miles'));
    await tester.pumpAndSettle(); // Wait for the dropdown to open and settle.
    await tester.tap(find.text('miles').last);
    await tester.pumpAndSettle(); // Wait for the dropdown to close.

    // Tap the 'Convert' button to perform the conversion.
    await tester.tap(find.text('Convert'));
    await tester.pump(); // Rebuild the widget after the state change.

    // Verify that the result is displayed as expected, e.g., '1 kilometer is 0.621 miles'.
    expect(find.textContaining('0.621 miles'), findsOneWidget);
  });
}
