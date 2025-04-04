import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'swipeFeature/home_page.dart';
import 'swipeFeature/profiles_brain.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfilesBrain(),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SwipePage(),
      ),
    );
  }
}
