import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:qr_scanner_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Test', () {
    testWidgets('App should start without errors', (WidgetTester tester) async {
      // Start the app
      app.main();
      
      // Wait for the app to settle
      await tester.pumpAndSettle();

      // A simple check to ensure the main screen is loaded.
      // We can check for a widget that is expected to be on the main screen.
      // For example, a NavigationBar.
      expect(find.byType(NavigationBar), findsOneWidget);
    });
  });
}
