import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:qr_scanner_app/main.dart' as app;
import 'package:qr_scanner_app/screens/main_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Test', () {
    testWidgets('App should start without errors', (WidgetTester tester) async {
      // Start the app
      app.main();
      
      // MainScreen veya NavigationBar görünene kadar kısa bekleme döngüsü (~5s)
      await tester.pump(const Duration(milliseconds: 100));
      for (int i = 0; i < 200; i++) {
        if (find.byType(MaterialApp).evaluate().isNotEmpty ||
            find.byType(MainScreen).evaluate().isNotEmpty ||
            find.byType(NavigationBar).evaluate().isNotEmpty) {
          break;
        }
        await tester.pump(const Duration(milliseconds: 100));
      }

      // Uygulamanın başladığını doğrula (MaterialApp görünmeli)
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
