// import 'package:amicae/features/login/pages/landing_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../nav bar/nav_bar.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: Container(
//         margin: const EdgeInsets.all(20),
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Text("profile page goes here")),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 color: Colors.black,
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     PageRouteBuilder(
//                       pageBuilder: (context, animation1, animation2) =>
//                           const NavBar(),
//                       transitionDuration: Duration.zero,
//                       reverseTransitionDuration: Duration.zero,
//                     ),
//                   );
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(builder:
//                   //     (context) => const NavBar()
//                   //   )
//                   // );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: IconButton(
//                 icon: const Icon(Icons.logout),
//                 color: Colors.black,
//                 onPressed: () {
//                   // TODO: firebase logout
//                   FirebaseAuth.instance.signOut();
//                   Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(
//                       builder: (context) => const LandingPage(),
//                     ),
//                     (route) => false,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:amicae/features/login/pages/landing_page.dart';
import 'package:amicae/features/profile/service/profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../nav bar/nav_bar.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfileService _profileService = ProfileService();

  @override
  Widget build(BuildContext context) {
    // _profileService.findById(FirebaseAuth.instance.currentUser?.uid ?? '').then((profile) {
    //   print(profile);
    // });
    // Get the current user
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display user ID if a user is logged in
            if (currentUser != null)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "User ID: ${currentUser.uid}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
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
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                icon: const Icon(Icons.logout),
                color: Colors.black,
                onPressed: () {
                  FirebaseAuth.instance.signOut();
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
