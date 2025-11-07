import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:feedback/feedback.dart';
import 'l10n/app_localizations.dart';

import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'providers/qr_provider.dart';
import 'services/database_service.dart';
import 'services/ad_service.dart';
import 'services/firebase_analytics_service.dart';
import 'core/constants/app_constants.dart';
import 'firebase_options.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style early
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );
  
  // Initialize critical services in parallel
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    DatabaseService.init(),
  ]);
  
  // Initialize Firebase Analytics
  await FirebaseAnalyticsService.initialize();
  
  // Initialize non-critical services lazily (don't wait)
  AdService.initialize().ignore();
  
  // Log app opened to Firebase only (single source)
  FirebaseAnalyticsService.logEvent(name: AppConstants.appOpened).ignore();
  
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
          return BetterFeedback(
            theme: FeedbackThemeData(
              background: Colors.black87,
              feedbackSheetColor: const Color(0xFF1E1E1E),
              drawColors: [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow,
              ],
            ),
            child: MaterialApp(
              title: 'QR Scanner',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,
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
            ),
          );
        },
      ),
    );
  }
}
