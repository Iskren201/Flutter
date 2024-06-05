import 'package:flutter/material.dart';
import 'package:project/pages/theme_notifier.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/settings_page.dart';
import 'pages/change_password_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.currentTheme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) {
          final username = ModalRoute.of(context)!.settings.arguments as String;
          return Home(username: username);
        },
        '/register': (context) => RegisterPage(),
        '/settings': (context) => SettingsPage(),
        '/change_password': (context) => ChangePasswordPage(),
      },
    );
  }
}
