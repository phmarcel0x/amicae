import 'package:amicae/features/login/pages/landing_page.dart';
import 'package:amicae/features/profile/entity/profile.dart';
import 'package:amicae/features/profile/service/profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:amicae/features/profile/edit_profile_page.dart';
import '../nav bar/nav_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with WidgetsBindingObserver {
  final ProfileService _profileService = ProfileService();
  // Key to force rebuild FutureBuilder when data changes
  Key _futureBuilderKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    // Add observer to detect when the app/page becomes active
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Remove observer when widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Refresh when app becomes active again
    if (state == AppLifecycleState.resumed) {
      _refreshProfile();
    }
  }

  // This will be called when the widget is inserted into the tree
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh the profile when dependencies change (which includes navigation)
    _refreshProfile();
  }

  void _refreshProfile() {
    setState(() {
      // Create a new key to force the FutureBuilder to rebuild
      _futureBuilderKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    // Debug prints
    print('Current User UID: ${currentUser?.uid}');
    print('Is User Authenticated: ${currentUser != null}');
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
      return const Center(
        child: Text(
          "No user logged in",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      );
    } else {
      ProfileService().checkDatabaseAccess(currentUser.uid);
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Your Profile"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LandingPage(),
                ),
                    (route) => false,
              );
            },
            icon: const Icon(Icons.logout_rounded),
            color: Colors.black,
          ),
        ],
      ),
      body: FutureBuilder<Profile>(
        key: _futureBuilderKey, // Add key here to force rebuild
        future: _profileService.findById(currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }

          if (snapshot.hasError) {
            print('Profile load error: ${snapshot.error}');
            print('Profile load error stack trace: ${snapshot.stackTrace}');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Error loading profile",
                    style: TextStyle(color: Colors.red[800], fontSize: 18),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                "No profile found",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            );
          }

          final Profile profile = snapshot.data!;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Add extra spacing from the physical area (camera, etc.)
                  const SizedBox(height: 30),

                  // Profile card with fixed height and scrollable content
                  Expanded(
                    child: ProfileCard(
                      profile: profile,
                      onBack: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) => const NavBar(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      onLogout: () {
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

                  // Edit Profile button with full width and more visibility
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // Removed the boxShadow here
                    ),
                    width: double.infinity, // Full width
                    height: 48, // Increased height for better visibility
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.edit_rounded, size: 24),
                      label: const Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Updated to 30px
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(profile: profile),
                          ),
                        ).then((updated) {
                          // If returning with 'true', refresh the profile data
                          if (updated == true) {
                            _refreshProfile(); // Call refresh method instead
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ProfileCard class remains unchanged
class ProfileCard extends StatelessWidget {
  final Profile profile;
  final VoidCallback onBack;
  final VoidCallback onLogout;

  const ProfileCard({
    super.key,
    required this.profile,
    required this.onBack,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30), // Border radius for the entire card
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image (now inside scrollable area)
              SizedBox(
                height: 260,
                width: double.infinity,
                child: Image.asset(
                  'assets/blank_pfp.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: Colors.grey[300],
                      width: double.infinity,
                      child: const Icon(Icons.person, size: 80, color: Colors.white),
                    );
                  },
                ),
              ),

              // Profile Content
              Padding(
                padding: const EdgeInsets.all(16),
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
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        profile.department,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue[800],
                        ),
                      ),
                    ),

                    const Divider(height: 24),

                    // Bio
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 4),
                      child: Text(
                        "My Bio",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      profile.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Education
                    const Text(
                      "My Education",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        profile.educationStatus,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Courses
                    const Text(
                      "My Courses",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: profile.coursesCodes.map((course) =>
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              course,
                              style: TextStyle(
                                color: Colors.blue[800],
                              ),
                            ),
                          )
                      ).toList(),
                    ),

                    const SizedBox(height: 16),

                    // Interests
                    const Text(
                      "My Interests",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: profile.interests.map((interest) =>
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              interest,
                              style: TextStyle(
                                color: Colors.grey[800],
                              ),
                            ),
                          )
                      ).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}