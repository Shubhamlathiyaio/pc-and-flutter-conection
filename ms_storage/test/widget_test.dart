// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ms_storage/main.dart';

void main() {
  testWidgets('App loads dashboard screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the dashboard screen is displayed
    expect(find.text('Welcome to the Store Management App'), findsOneWidget);

    // Verify that the navigation buttons are present
    expect(find.text('Add Product'), findsOneWidget);
    expect(find.text('View Products'), findsOneWidget);
    expect(find.text('Add Customer'), findsOneWidget);
  });
}
