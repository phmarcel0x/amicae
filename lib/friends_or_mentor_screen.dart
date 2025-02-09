import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'your_life_screen.dart';

class FriendsOrMentorsScreen extends StatefulWidget {
  const FriendsOrMentorsScreen({super.key});

  @override
  State<FriendsOrMentorsScreen> createState() => _FriendsOrMentorsScreenState();
}

class _FriendsOrMentorsScreenState extends State<FriendsOrMentorsScreen> {
  String? _selectedMode; // No option selected at first (null)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(),
        elevation: 0,
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
            // White container for 'Date' option
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
                title: Text('BFF', style: GoogleFonts.lato(),),
                subtitle: Text('Make new friends at every stage of your life', style: GoogleFonts.lato(),),
                value: 'BFF',
                groupValue: _selectedMode,
                activeColor: Colors.black87,
                onChanged: (String? value) {
                  setState(() {
                    _selectedMode = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
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
                title: Text('Mentor', style: GoogleFonts.lato(),),
                subtitle: Text('Find that special connection in the community', style: GoogleFonts.lato(),),
                value: 'Mentor',
                groupValue: _selectedMode,
                activeColor: Colors.black87,
                onChanged: (String? value) {
                  setState(() {
                    _selectedMode = value;
                  });
                },
              ),
            ),
            SizedBox(height: 269),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  icon: Icon(Icons.arrow_circle_right_sharp, size: 50, color: Colors.black),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => YourLifeScreen()),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
