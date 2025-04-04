import 'package:flutter/material.dart';
import "../home/home.dart";
import "../people/people.dart";
import "../events/events_api.dart";
import "../spots/spots.dart";
import "../profile/profile_page.dart";

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
    SpotsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // This will intercept the back press or swipe back gesture
      onWillPop: () async {
        return false; // Disable backswiping and hardware back button
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 200),
                child: Image.asset(
                  "assets/ae_short_white.png",
                  fit: BoxFit.contain,
                  height: 70,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  icon: const Icon(Icons.account_circle_rounded),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage()));
                  },
                ),
              ),
            ],
          ),
          shape: const Border(bottom: BorderSide(color: Colors.black, width: 4)),
        ),
        body: pages[selectedIndex],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.black,
                width: 3,
              )
            )
          ),
          child: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: false,
            selectedFontSize: 15,
            selectedItemColor: Colors.black,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_rounded),
                label: "Connections",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_rounded),
                label: "Events",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.coffee_rounded),
                label: "Spots",
              ),
            ],
            currentIndex: selectedIndex,
            onTap: onItemTapped,
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}