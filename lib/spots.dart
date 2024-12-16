import 'package:flutter/material.dart';

class SpotsPage extends StatefulWidget {
  const SpotsPage({super.key});

  @override
  State createState() => _SpotsPage();
}

class _SpotsPage extends State<SpotsPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(

            backgroundColor: Colors.green,
            body: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("spots page goes here")
                  ),

                ],
              ),
            )
        )
    );
  }
}