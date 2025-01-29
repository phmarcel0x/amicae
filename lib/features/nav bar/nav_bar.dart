import 'package:flutter/material.dart';

import "../home/home.dart";
import "../people/people.dart";
import "../events/events_api.dart";
import "../spots/spots.dart";
import "../profile/profile.dart";

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
    const API_EventsPage(),
    const SpotsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/ae_short_white.png",
                  fit: BoxFit.contain,
                  height: 100,
                ),

              ],
            )
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 15,
            selectedItemColor: Colors.orange,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedItemColor: Colors.black,
            // showSelectedLabels: false,
            // showUnselectedLabels: false,
            backgroundColor: Colors.white,
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