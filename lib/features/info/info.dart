import 'package:flutter/material.dart';

import "../nav bar/nav_bar.dart";

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State createState() => _InfoPage();
}

class _InfoPage extends State<InfoPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.purple,
            body: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("WELCOME TO AMICAE")
                  ),
                  const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Amicae is a mobile app designed to connect students at Concordia University with mentors and potential study buddies based on shared interests. It also recommends the best on- and off- campus study spots to support academic success.",
                        textAlign: TextAlign.center,
                      )
                  ),
                  const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("info page goes here")
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => const NavBar(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder:
                          //     (context) => const NavBar()
                          //   )
                          // );
                        }
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
}