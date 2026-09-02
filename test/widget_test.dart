// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hospital/main.dart';

void main() {
  testWidgets('logs in to the microbiology dashboard with referral and dispatch',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Department of Microbiology'), findsOneWidget);
    expect(find.text('Department email'), findsOneWidget);
    expect(find.text('Welcome back'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Microbiology Unit'), findsOneWidget);
    expect(find.text('Patient list'), findsOneWidget);
    expect(find.text('Priya Sharma'), findsAtLeastNWidgets(1));
    expect(find.text('Referred from: Emergency Department'), findsOneWidget);
    expect(find.text('Send completed results to reception'), findsOneWidget);
  });
}
