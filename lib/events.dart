import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State createState() => _EventsPage();
}

class _EventsPage extends State<EventsPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.yellow,
            body: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("events page goes here")
                  ),

                ],
              ),
            )
        )
    );
  }
}