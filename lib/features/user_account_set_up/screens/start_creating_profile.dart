import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/user_profile_service.dart';

import '../models/user_department.dart';
import '../models/user_edu_status.dart';

import '../screens/amicae_firstname_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _userProfileService = UserProfileService();
  var _isCreating = false;

  Future<void> _initializeProfile() async {
    setState(() {
      _isCreating = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User is not authenticated')),
          );
        }
        return;
      }

      // Debug: Print user auth state
      print('User ID: ${user.uid}');
      print('User Email: ${user.email}');
      print('User is authenticated: ${user != null}');
      print('User token: ${await user.getIdToken()}');

      // Initialize with default values - these will be updated in subsequent screens
      await _userProfileService.initializeProfile(
        firstName: '',
        description: '',
        lookingFor: '',
        educationStatus: EducationStatus.InCollege,
        department:
            UserDepartment.GinaCodySchoolOfEngineeringAndComputerScience,
        interests: [],
        coursesCodes: [],
      );

      // Navigate to the first name screen
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AmicaeFirstNameScreen(documentId: user.uid),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to initialize profile: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCreating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/ae_short_white.png',
                width: 300,
              ),
              // const SizedBox(height: 80),

              Center(
                child: Text(
                  'Connect, study, and succeed with Amicae',
                  style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 80),
              OutlinedButton.icon(
                onPressed: _isCreating ? null : _initializeProfile,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                icon: _isCreating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.person),
                label: Text(
                  _isCreating ? 'Creating...' : 'Start building your profile',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
