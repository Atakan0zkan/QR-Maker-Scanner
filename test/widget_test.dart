import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_app/l10n/app_localizations.dart';
import 'package:qr_scanner_app/providers/locale_provider.dart';
import 'package:qr_scanner_app/providers/qr_provider.dart';
import 'package:qr_scanner_app/providers/theme_provider.dart';
import 'package:qr_scanner_app/screens/main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  testWidgets('MainScreen has a bottom navigation bar with 4 items', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          ChangeNotifierProvider(create: (_) => QRProvider()),
        ],
        child: const MaterialApp(
          home: MainScreen(),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
          ],
        ),
      ),
    );

    // Wait for the widgets to settle
    await tester.pumpAndSettle();

    // Verify that the BottomNavigationBar items are present
    expect(find.text('Scan'), findsOneWidget);
    expect(find.text('Create'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });
}