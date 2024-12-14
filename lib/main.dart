import 'package:flutter/material.dart';
import "features/login/index.dart";

void main() {
  runApp(MaterialApp(
    home: const LandingPage(),
    theme: AppThemes.lightTheme,
    darkTheme: AppThemes.darkTheme,
    themeMode: ThemeMode.system,

  ));
}

class AppColors {
  static const black = Colors.black;
  static const white = Colors.white;

}

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.white,
    brightness: Brightness.light
  );
  static final darkTheme = ThemeData(
    primaryColor: AppColors.black,
    brightness: Brightness.dark
  );
}

//Home page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green,
        body: Container(
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text("home page goes here")
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      }
                  )
              ),
            ],
          ),
        )
      )
    );
  }
}