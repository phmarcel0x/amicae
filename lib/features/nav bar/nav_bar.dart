import 'package:flutter/material.dart';
import "../home/home.dart";
import "../people/people.dart";
import "../events/events_api.dart";
import "../spots/spots.dart";
import "../profile/profile.dart";
import "../info/info.dart";

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    const HomePage(),
    const PeoplePage(),
    const APIEventsPage(),
    const SpotsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 200),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InfoPage()
                      )
                    );
                  }, // Image tapped
                  child: Image.asset(
                    "assets/ae_short_white.png",
                    fit: BoxFit.contain,
                    height: 70,
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  icon: const Icon(Icons.account_circle),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage()
                      )
                    );
                  }
                ),
              ),
            ],
          ),
          shape: const Border(
            bottom: BorderSide(color: Colors.black, width: 4)
          ),
        ),

        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 15,
          selectedItemColor: Colors.orange,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: Colors.black,
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,

          items: const <BottomNavigationBarItem>[
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
          ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ),
        backgroundColor: Colors.white,
      )
    );
  }
}
