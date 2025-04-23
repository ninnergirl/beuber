import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:beuber/pages/home_page.dart';
import 'package:beuber/pages/login_page.dart';
import 'package:beuber/pages/register_page.dart';
import 'package:beuber/pages/certificate_check_page.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const BeUberApp());
}

class BeUberApp extends StatelessWidget {
  const BeUberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeUber',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('uz')],
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/verify_certificate': (context) => const CertificateCheckPage(),
      },
    );
  }
}
