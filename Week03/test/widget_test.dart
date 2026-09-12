import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:week3_navigation_state_management/main.dart';

void main() {
  testWidgets('Home page displays navigation items', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 10'), findsOneWidget);
  });
}
