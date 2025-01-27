import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State createState() => _EventsPage();
}

class _EventsPage extends State<EventsPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.yellow,
        body: Container(

          margin: const EdgeInsets.all(20),
          width: double.infinity,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
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