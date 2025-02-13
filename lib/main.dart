import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/login/pages/landing_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}

class AppColors {
  static const black = Colors.black;
  static const white = Colors.white;
}

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.white,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.black,
    brightness: Brightness.dark,
  );
}
