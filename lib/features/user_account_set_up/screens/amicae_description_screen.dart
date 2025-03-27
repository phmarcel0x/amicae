// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:http/http.dart' as http;
//
// import '../screens/amicae_profile_picture_screen.dart';
// import '../screens/amicae_mode_screen.dart';
//
// class AmicaeDescriptionScreen extends StatefulWidget {
//   const AmicaeDescriptionScreen({super.key, required this.documentId});
//
//   final String documentId;
//
//   @override
//   _AmicaeDescriptionScreen createState() => _AmicaeDescriptionScreen();
// }
//
// class _AmicaeDescriptionScreen extends State<AmicaeDescriptionScreen> {
//   final TextEditingController _controller = TextEditingController();
//   bool isButtonEnabled = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(_onTextChanged);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _onTextChanged() {
//     setState(() {
//       isButtonEnabled = _controller.text.isNotEmpty;
//     });
//   }
//
//   Future<void> updateDescription(String documentId, String description) async {
//     // Construct the Firebase URL using the document ID to update the specific user's profile
//     final url = Uri.https(
//       'amicae-app-default-rtdb.firebaseio.com',
//       'user-profile/$documentId.json',
//     );
//
//     try {
//       // Send PATCH request to update the first name
//       final response = await http.patch(
//         url,
//         body: json.encode({'description': description}), // Sending the first name as JSON
//       );
//
//       if (response.statusCode == 200) {
//         print('Description updated successfully!');
//         // Optionally navigate to the next screen or give feedback to the user
//       } else {
//         print('Failed to update description: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error occurred: $error');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 40), // Space from top
//             Text(
//               "Tell us and everybody more about you",
//               style: GoogleFonts.lato(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: 12),
//             Text(
//               "Don't worry, you can change this later.",
//               style: GoogleFonts.lato(
//                 fontSize: 16,
//                 color: Colors.black54,
//               ),
//             ),
//             SizedBox(height: 24),
//             Container(
//               width: double.infinity,
//               height: 150,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 6.0, // Soft blur effect
//                     offset: Offset(0, 2), // Slight vertical shadow
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 controller: _controller,
//                 decoration: InputDecoration(
//                   hintText: "Add your description",
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 keyboardType: TextInputType.multiline, // Enable multiline input
//                 maxLines: null,                       // Allow unlimited lines (within container height)
//                 expands: true,                        // TextField expands to fill container
//               ),
//             ),
//             Spacer(),
//             Row(
//               children: [
//                 Icon(
//                   Icons.remove_red_eye,
//                   color: Colors.black,
//                   size: 20.0,
//                 ),
//                 SizedBox(width: 4.0),
//                 Expanded(
//                   child: Text(
//                     'This will be shown on your profile.',
//                     style: GoogleFonts.lato(
//                       fontSize: 12.0,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 CircleAvatar(
//                   backgroundColor: Colors.white,
//                   radius: 28,
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.arrow_circle_right_sharp,
//                       size: 50,
//                       color: isButtonEnabled ? Colors.black : Colors.grey, // Conditional color
//                     ),
//                     onPressed: isButtonEnabled
//                         ? () {
//                       updateDescription(widget.documentId, _controller.text);
//                       // Handle forward button press
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => AmicaeModeScreen(documentId: widget.documentId)),
//                       );
//                     }
//                         : null, // Disable button if input is empty
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

import '../screens/amicae_mode_screen.dart';

class AmicaeDescriptionScreen extends StatefulWidget {
  const AmicaeDescriptionScreen({super.key, required this.documentId});

  final String documentId;

  @override
  _AmicaeDescriptionScreen createState() => _AmicaeDescriptionScreen();
}

class _AmicaeDescriptionScreen extends State<AmicaeDescriptionScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      isButtonEnabled = _controller.text.isNotEmpty;
    });
  }

  Future<void> updateDescription(String documentId, String description) async {
    try {
      // Get a reference to the specific user's profile in the database
      final DatabaseReference ref = FirebaseDatabase.instance
          .ref()
          .child('user-profile')
          .child(documentId);

      // Update the description
      await ref.update({
        'description': description,
      });

      print('Description updated successfully!');
    } catch (error) {
      print('Error occurred while updating description: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40), // Space from top
            Text(
              "Tell us and everybody more about you",
              style: GoogleFonts.lato(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Don't worry, you can change this later.",
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0, // Soft blur effect
                    offset: Offset(0, 2), // Slight vertical shadow
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Add your description",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.multiline, // Enable multiline input
                maxLines: null,                       // Allow unlimited lines (within container height)
                expands: true,                        // TextField expands to fill container
              ),
            ),
            Spacer(),
            Row(
              children: [
                Icon(
                  Icons.remove_red_eye,
                  color: Colors.black,
                  size: 20.0,
                ),
                SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    'This will be shown on your profile.',
                    style: GoogleFonts.lato(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                CircleAvatar(
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
                      updateDescription(widget.documentId, _controller.text);
                      // Handle forward button press
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AmicaeModeScreen(documentId: widget.documentId)),
                      );
                    }
                        : null, // Disable button if input is empty
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}