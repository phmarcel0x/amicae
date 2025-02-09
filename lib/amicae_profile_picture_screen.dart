import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'friends_or_mentor_screen.dart';

class AmicaeProfilePictureScreen extends StatelessWidget {
  const AmicaeProfilePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(),
        elevation: 0,
      ),// Similar background color
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add your picture',
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Blah...blah...blah...ehhhhhh Your picture for your profile',
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _photoPlaceholder(),
              ],
            ),
            SizedBox(height: 325),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  icon: Icon(Icons.arrow_circle_right_sharp, size: 50, color: Colors.black),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FriendsOrMentorsScreen()),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _photoPlaceholder() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!, width: 2),
      ),
      child: Center(
        child: Icon(Icons.add, size: 48, color: Colors.grey[500]),
      ),
    );
  }
}
