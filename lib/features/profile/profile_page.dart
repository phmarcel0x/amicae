// // import 'package:amicae/features/login/pages/landing_page.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// //
// // import '../nav bar/nav_bar.dart';
// //
// // class ProfilePage extends StatelessWidget {
// //   const ProfilePage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.blue,
// //       body: Container(
// //         margin: const EdgeInsets.all(20),
// //         width: double.infinity,
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             const Padding(
// //                 padding: EdgeInsets.all(10),
// //                 child: Text("profile page goes here")),
// //             Padding(
// //               padding: const EdgeInsets.all(10),
// //               child: IconButton(
// //                 icon: const Icon(Icons.arrow_back),
// //                 color: Colors.black,
// //                 onPressed: () {
// //                   Navigator.pushReplacement(
// //                     context,
// //                     PageRouteBuilder(
// //                       pageBuilder: (context, animation1, animation2) =>
// //                           const NavBar(),
// //                       transitionDuration: Duration.zero,
// //                       reverseTransitionDuration: Duration.zero,
// //                     ),
// //                   );
// //                   // Navigator.push(
// //                   //   context,
// //                   //   MaterialPageRoute(builder:
// //                   //     (context) => const NavBar()
// //                   //   )
// //                   // );
// //                 },
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(10),
// //               child: IconButton(
// //                 icon: const Icon(Icons.logout),
// //                 color: Colors.black,
// //                 onPressed: () {
// //                   // TODO: firebase logout
// //                   FirebaseAuth.instance.signOut();
// //                   Navigator.of(context).pushAndRemoveUntil(
// //                     MaterialPageRoute(
// //                       builder: (context) => const LandingPage(),
// //                     ),
// //                     (route) => false,
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:amicae/features/login/pages/landing_page.dart';
// import 'package:amicae/features/profile/service/profile_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../nav bar/nav_bar.dart';
//
// class ProfilePage extends StatelessWidget {
//   ProfilePage({super.key});
//
//   final ProfileService _profileService = ProfileService();
//
//   @override
//   Widget build(BuildContext context) {
//     // _profileService.findById(FirebaseAuth.instance.currentUser?.uid ?? '').then((profile) {
//     //   print(profile);
//     // });
//     // Get the current user
//     final User? currentUser = FirebaseAuth.instance.currentUser;
//
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: Container(
//         margin: const EdgeInsets.all(20),
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Display user ID if a user is logged in
//             if (currentUser != null)
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Text(
//                   "User ID: ${currentUser.uid}",
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
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
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: IconButton(
//                 icon: const Icon(Icons.logout),
//                 color: Colors.black,
//                 onPressed: () {
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
import 'package:amicae/features/profile/entity/profile.dart';
import 'package:amicae/features/profile/service/profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../nav bar/nav_bar.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfileService _profileService = ProfileService();

  @override
  Widget build(BuildContext context) {
    // Get the current user
    final User? currentUser = FirebaseAuth.instance.currentUser;

    // Add these debug prints
    print('Current User UID: ${currentUser?.uid}');
    print('Is User Authenticated: ${currentUser != null}');

    // Additional authentication details
    print('Current User Email: ${currentUser?.email}');
    print('Current User Email Verified: ${currentUser?.emailVerified}');
    print('Current User Providers: ${currentUser?.providerData}');

    // Check authentication token
    currentUser?.getIdToken().then((token) {
      print('Authentication Token: ${token?.isNotEmpty}');
    }).catchError((error) {
      print('Error getting authentication token: $error');
    });

    if (currentUser == null) {
      return Center(
        child: Text(
          "No user logged in",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    } else if (currentUser != null) {
      ProfileService().checkDatabaseAccess(currentUser.uid);
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      body: currentUser != null
          ? FutureBuilder<Profile>(
        future: _profileService.findById(currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Error loading profile",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const NavBar()),
                      );
                    },
                    child: const Text("Go Back"),
                  )
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                "No profile found",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }

          final Profile profile = snapshot.data!;

          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Information Display
                  ProfileInfoCard(profile: profile),

                  // Navigation and Logout Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                ],
              ),
            ),
          );
        },
      )
          : const Center(
        child: Text(
          "No user logged in",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class ProfileInfoCard extends StatelessWidget {
  final Profile profile;

  const ProfileInfoCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name and Department
            Text(
              profile.firstName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              profile.department,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),

            // Description
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              profile.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),

            // Education Status
            const Text(
              'Education Status:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              profile.educationStatus,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),

            // Courses
            const Text(
              'Courses:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: profile.coursesCodes.map((course) =>
                  Chip(
                    label: Text(course),
                    backgroundColor: Colors.blue.shade100,
                  )
              ).toList(),
            ),
            const SizedBox(height: 15),

            // Interests
            const Text(
              'Interests:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: profile.interests.map((interest) =>
                  Chip(
                    label: Text(interest),
                    backgroundColor: Colors.green.shade100,
                  )
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}