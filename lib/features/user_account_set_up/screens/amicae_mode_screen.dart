import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

// import 'package:amicae_v5/screens/amicae_profile_picture_screen.dart';

import '../screens/amicae_edu_status_screen.dart';

class AmicaeModeScreen extends StatefulWidget {
  const AmicaeModeScreen({super.key, required this.documentId});

  final String documentId;

  @override
  _AmicaeModeScreenState createState() => _AmicaeModeScreenState();
}

class _AmicaeModeScreenState extends State<AmicaeModeScreen> {
  String? _selectedMode; // No option selected at first (null)
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // Initialize button state (optional, as it's false by default)
  }

  void _onModeChanged(String? value) {
    setState(() {
      _selectedMode = value;
      isButtonEnabled = _selectedMode != null; // Enable if a mode is selected
    });
  }

  Future<void> updateMode(String documentId, String selectedMode) async {
    // Construct the Firebase URL using the document ID to update the specific user's profile
    final url = Uri.https(
      'amicae-app-default-rtdb.firebaseio.com',
      'user-profile/$documentId.json',
    );

    try {
      // Send PATCH request to update the  mode
      final response = await http.patch(
        url,
        body: json.encode({'lookingFor': selectedMode}), // Sending the mode as JSON
      );

      if (response.statusCode == 200) {
        print('Mode updated successfully!');
      } else {
        print('Failed to update mode: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a mode to get started',
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Amicae\'s for making all kinds of connections! You\'ll be able to switch modes once you\'re all set up.',
              style: GoogleFonts.lato(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 40),
            // White container for 'BFF' option
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: RadioListTile<String>(
                title: Text('BFF', style: GoogleFonts.lato()),
                subtitle: Text('Make new friends at every stage of your life', style: GoogleFonts.lato()),
                value: 'BFF',
                groupValue: _selectedMode,
                activeColor: Colors.black87,
                onChanged: _onModeChanged, // Use _onModeChanged
              ),
            ),
            SizedBox(height: 20),
            // White container for 'Mentor' option
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: RadioListTile<String>(
                title: Text('Mentor', style: GoogleFonts.lato()),
                subtitle: Text('Find that special connection in the community', style: GoogleFonts.lato()),
                value: 'Mentor',
                groupValue: _selectedMode,
                activeColor: Colors.black87,
                onChanged: _onModeChanged, // Use _onModeChanged
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 28,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_circle_right_sharp,
                    size: 50,
                    color: isButtonEnabled ? Colors.black : Colors.grey, // Conditional color
                  ),
                  onPressed: isButtonEnabled
                      ? () {
                    updateMode(widget.documentId, _selectedMode!);
                    // Handle forward button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AmicaeEduStatusScreen(documentId: widget.documentId)),
                    );
                  }
                      : null, // Disable button if no mode is selected
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}