import 'package:flutter/material.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State createState() => _PeoplePage();
}

class _PeoplePage extends State<PeoplePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(
            backgroundColor: Colors.pink,
            body: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("people page goes here")
                  ),

                ],
              ),
            )
        )
    );
  }
}