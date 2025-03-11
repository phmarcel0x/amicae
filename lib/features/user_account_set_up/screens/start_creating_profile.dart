import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../data/courses_codes.dart';
import '../data/departments.dart';
import '../data/education_status.dart';
import '../data/interests.dart';

import '../models/user_interest.dart';
import '../models/user_department.dart';
import '../models/user_edu_status.dart';
import '../models/user_courses_code.dart';

import '../screens/amicae_firstname_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  var _enteredFirstName = '';
  var _enteredDescription = '';
  var _selectedLookingFor = '';
  var _selectedEduStatus = educationStatusMap[EducationStatus.InCollege]!;
  var _selectedDepartment = departmentDetails[
      UserDepartment.GinaCodySchoolOfEngineeringAndComputerScience]!;
  // List<dynamic> _selectedInterests = [interests[Interests.Acting]!.title, interests[Interests.AdventureTrips]!.title];
  // List<dynamic> _selectedCoursesCode = [coursesCodes[CourseCode.ACCO]!.courseCode,coursesCodes[CourseCode.ADED]!.courseCode,];
  List<dynamic> _selectedInterests = ['', ''];
  List<dynamic> _selectedCoursesCode = ['', ''];
  var _isCreating = false;

  void _addUser() async {
    setState(() {
      _isCreating = true;
    });

    // Get the current user UID from Firebase Authentication
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle user not signed in
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User is not authenticated')),
      );
      return;
    }
    final String documentId = user.uid;

    // Use the user's UID as the document ID in the database
    final url = Uri.https(
        'amicae-app-default-rtdb.firebaseio.com', 'user-profile/$documentId.json');

    final response = await http.put( // Use PUT instead of POST to set data under a specific key
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'firstName': _enteredFirstName,
          'description': _enteredDescription,
          'lookingFor': _selectedLookingFor,
          'eduStatus': _selectedEduStatus.title,
          'department': _selectedDepartment.title,
          'interests': _selectedInterests,
          'courses': _selectedCoursesCode,
        },
      ),
    );

    if (response.statusCode == 200) {
      // Navigate to the next screen using the user's UID
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AmicaeFirstNameScreen(documentId: documentId),
        ),
      );
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create user profile')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors:
                [Colors.white,
                  Colors.white]
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/ae_short_white.png',
                width: 300,
              ),
              const SizedBox(height: 80),
              Text(
                'Connecting peers to peers',
                style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 0, 0, 0), fontSize: 24),
              ),
              const SizedBox(height: 80),
              OutlinedButton.icon(
                // onPressed: startQuiz,
                onPressed: _isCreating ? null : _addUser,
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black, foregroundColor: Colors.white),
                icon: const Icon(Icons.person),
                label: const Text(
                  'Start building',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
