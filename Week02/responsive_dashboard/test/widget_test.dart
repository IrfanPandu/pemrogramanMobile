import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_dashboard/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets(
    'Dashboard satu kolom di layar sempit',
    (tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        const DashboardApp(),
      );

      expect(
        find.byType(InfoCard),
        findsNWidgets(5),
      );
    },
  );

  testWidgets(
    'Dashboard dua kolom di layar lebar',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        const DashboardApp(),
      );

      expect(
        find.byType(InfoCard),
        findsNWidgets(5),
      );
    },
  );

  testWidgets(
    'Dark mode dapat diaktifkan',
    (tester) async {
      await tester.pumpWidget(
        const DashboardApp(),
      );

      expect(find.byType(CupertinoSwitch), findsOneWidget);

      await tester.tap(
        find.byType(CupertinoSwitch),
      );

      await tester.pump();

      expect(
        find.byIcon(Icons.dark_mode),
        findsOneWidget,
      );
    },
  );
}