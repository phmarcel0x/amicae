import 'package:amicae/pages/landing_page.dart';
import 'package:flutter/material.dart';

import '../nav bar/nav_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.all(10),
                child: Text("profile page goes here")),
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const NavBar(),
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
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                icon: const Icon(Icons.logout),
                color: Colors.black,
                onPressed: () {
                  // TODO: firebase logout
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LandingPage(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
