import 'package:flutter/material.dart';

import "home.dart";
import "people.dart";
import "events.dart";
import "spots.dart";
import "profile.dart";

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    const HomePage(),
    const PeoplePage(),
    const EventsPage(),
    const SpotsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/ae_long_black.png",
                  fit: BoxFit.contain,
                  height: 200,
                ),

              ],
            )
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 15,
            selectedItemColor: Colors.orange,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedItemColor: Colors.white,
            // showSelectedLabels: false,
            // showUnselectedLabels: false,
            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,

            items: const <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: "People",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event),
                label: "Events",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.coffee),
                label: "Spots",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: "Profile",
              )
            ],
            currentIndex: selectedIndex,
            onTap: onItemTapped,
          ),
          backgroundColor: Colors.white,
          body: pages[selectedIndex],
        )
    );
  }
}