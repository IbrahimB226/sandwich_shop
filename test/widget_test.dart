import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/screens/menu_screen.dart';
import 'package:sandwich_shop/screens/order_screen.dart';

void main() {
  group('App smoke tests', () {
    testWidgets('App starts and displays menu screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      expect(find.byType(MenuScreen), findsOneWidget);
      expect(find.text('Sandwich Menu'), findsOneWidget);
    });

    testWidgets('App displays sandwich cards', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      expect(find.text('Footlong Sub'), findsOneWidget);
      expect(find.text('Six-Inch Sub'), findsOneWidget);
      expect(find.text('Order'), findsNWidgets(2));
    });

    testWidgets(
      'Tapping Order navigates to OrderScreen with selected sandwich',
      (WidgetTester tester) async {
        await tester.pumpWidget(const App());

        await tester.tap(find.text('Order').first);
        await tester.pumpAndSettle();

        expect(find.byType(OrderScreen), findsOneWidget);
        expect(find.text('Order Footlong Sub'), findsOneWidget);
        expect(find.text('0 Footlong Sub sandwich(es): '), findsOneWidget);

        await tester.tap(find.text('Add'));
        await tester.pump();

        expect(
          find.text('1 Footlong Sub sandwich(es): 🥪'),
          findsOneWidget,
        );

        await tester.tap(find.text('Remove'));
        await tester.pump();

        expect(
          find.text('0 Footlong Sub sandwich(es): '),
          findsOneWidget,
        );
      },
    );
  });
}