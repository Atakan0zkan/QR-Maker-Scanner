import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'providers/qr_provider.dart';
import 'services/database_service.dart';
import 'services/ad_service.dart';
import 'services/analytics_service.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  await DatabaseService.init();
  await AdService.initialize();
  await AnalyticsService.init();
  
  // Log app opened
  await AnalyticsService.logEvent('app_opened');
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => QRProvider()),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, _) {
          return MaterialApp(
            title: 'QR Scanner',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.dark,
            locale: localeProvider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('tr'),
              Locale('es'),
              Locale('de'),
              Locale('fr'),
              Locale('it'),
              Locale('el'),
              Locale('ar'),
              Locale('zh'),
              Locale('ja'),
            ],
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
