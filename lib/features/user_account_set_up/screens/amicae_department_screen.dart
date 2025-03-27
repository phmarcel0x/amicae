// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:http/http.dart' as http;
//
// import '../screens/amicae_profile_picture_screen.dart';
// import '../screens/amicae_interest_screen.dart';
//
// import '../models/user_department.dart';
// import '../data/departments.dart';
//
// class AmicaeDepartmentScreen extends StatefulWidget {
//   const AmicaeDepartmentScreen({super.key, required this.documentId});
//
//   final String documentId;
//
//   @override
//   State<AmicaeDepartmentScreen> createState() => _AmicaeDepartmentScreenState();
// }
//
// class _AmicaeDepartmentScreenState extends State<AmicaeDepartmentScreen> {
//   var _selectedMode; // No option selected at first (null)
//   bool isButtonEnabled = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize button state (optional, as it's false by default)
//   }
//
//   void _onModeChanged(String? value) {
//     setState(() {
//       _selectedMode = value;
//       isButtonEnabled = _selectedMode != null; // Enable if a mode is selected
//     });
//   }
//
//   Future<void> updateDepartment(String documentId, String selectedMode) async {
//     // Construct the Firebase URL using the document ID to update the specific user's profile
//     final url = Uri.https(
//       'amicae-app-default-rtdb.firebaseio.com',
//       'user-profile/$documentId.json',
//     );
//
//     try {
//       // Send PATCH request to update the  mode
//       final response = await http.patch(
//         url,
//         body: json.encode({'department': selectedMode}), // Sending the mode as JSON
//       );
//
//       if (response.statusCode == 200) {
//         print('Department updated successfully!');
//       } else {
//         print('Failed to update department: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error occurred: $error');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//       ),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Choose your department',
//               style: GoogleFonts.lato(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Amicae\'s for making all kinds of connections! You\'ll be able to switch modes once you\'re all set up.',
//               style: GoogleFonts.lato(fontSize: 16, color: Colors.black87),
//             ),
//             SizedBox(height: 40),
//
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 4,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: RadioListTile<String>(
//                 title: Text('${departmentDetails[UserDepartment.FacultyOfArtsAndScience]!.emoji} Faculty of Art and Science', style: GoogleFonts.lato()),
//                 value: departmentDetails[UserDepartment.FacultyOfArtsAndScience]!.title,
//                 groupValue: _selectedMode,
//                 activeColor: Colors.black87,
//                 onChanged: _onModeChanged, // Use _onModeChanged
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 4,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: RadioListTile<String>(
//                 title: Text('${departmentDetails[UserDepartment.JohnMolsonSchoolOfBusiness]!.emoji} John Molson School of Business', style: GoogleFonts.lato()),
//                 value: departmentDetails[UserDepartment.JohnMolsonSchoolOfBusiness]!.title,
//                 groupValue: _selectedMode,
//                 activeColor: Colors.black87,
//                 onChanged: _onModeChanged, // Use _onModeChanged
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 4,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: RadioListTile<String>(
//                 title: Text('${departmentDetails[UserDepartment.GinaCodySchoolOfEngineeringAndComputerScience]!.emoji} Gina Cody School of Engineering and Computer Science', style: GoogleFonts.lato()),
//                 value: departmentDetails[UserDepartment.GinaCodySchoolOfEngineeringAndComputerScience]!.title,
//                 groupValue: _selectedMode,
//                 activeColor: Colors.black87,
//                 onChanged: _onModeChanged, // Use _onModeChanged
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 4,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: RadioListTile<String>(
//                 title: Text('${departmentDetails[UserDepartment.FacultyOfFineArts]!.emoji} Faculty of Fine Arts', style: GoogleFonts.lato()),
//                 value: departmentDetails[UserDepartment.FacultyOfFineArts]!.title,
//                 groupValue: _selectedMode,
//                 activeColor: Colors.black87,
//                 onChanged: _onModeChanged, // Use _onModeChanged
//               ),
//             ),
//             SizedBox(height: 20),
//
//             Spacer(),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 radius: 28,
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.arrow_circle_right_sharp,
//                     size: 50,
//                     color: isButtonEnabled ? Colors.black : Colors.grey, // Conditional color
//                   ),
//                   onPressed: isButtonEnabled
//                       ? () {
//                     updateDepartment(widget.documentId, _selectedMode!);
//                     // Handle forward button press
//                     Navigator.push(
//                       context,
//                       // MaterialPageRoute(builder: (context) => AmicaeProfilePictureScreen(documentId: widget.documentId)),
//                       MaterialPageRoute(builder: (context) => AmicaeInterestScreen(documentId: widget.documentId)),
//                     );
//                   }
//                       : null, // Disable button if no mode is selected
//                 ),
//               ),
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

import '../screens/amicae_interest_screen.dart';

import '../models/user_department.dart';
import '../data/departments.dart';

class AmicaeDepartmentScreen extends StatefulWidget {
  const AmicaeDepartmentScreen({super.key, required this.documentId});

  final String documentId;

  @override
  State<AmicaeDepartmentScreen> createState() => _AmicaeDepartmentScreenState();
}

class _AmicaeDepartmentScreenState extends State<AmicaeDepartmentScreen> {
  var _selectedMode; // No option selected at first (null)
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

  Future<void> updateDepartment(String documentId, String selectedMode) async {
    try {
      // Get reference to the specific user's profile in the database
      final DatabaseReference userRef = FirebaseDatabase.instance
          .ref()
          .child('user-profile')
          .child(documentId);

      // Update the department
      await userRef.update({
        'department': selectedMode,
      });

      print('Department updated successfully!');
    } catch (error) {
      print('Error occurred while updating department: $error');
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
              'Choose your department',
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
                title: Text('${departmentDetails[UserDepartment.FacultyOfArtsAndScience]!.emoji} Faculty of Art and Science', style: GoogleFonts.lato()),
                value: departmentDetails[UserDepartment.FacultyOfArtsAndScience]!.title,
                groupValue: _selectedMode,
                activeColor: Colors.black87,
                onChanged: _onModeChanged,
              ),
            ),
            SizedBox(height: 20),
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
                title: Text('${departmentDetails[UserDepartment.JohnMolsonSchoolOfBusiness]!.emoji} John Molson School of Business', style: GoogleFonts.lato()),
                value: departmentDetails[UserDepartment.JohnMolsonSchoolOfBusiness]!.title,
                groupValue: _selectedMode,
                activeColor: Colors.black87,
                onChanged: _onModeChanged,
              ),
            ),
            SizedBox(height: 20),
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
                title: Text('${departmentDetails[UserDepartment.GinaCodySchoolOfEngineeringAndComputerScience]!.emoji} Gina Cody School of Engineering and Computer Science', style: GoogleFonts.lato()),
                value: departmentDetails[UserDepartment.GinaCodySchoolOfEngineeringAndComputerScience]!.title,
                groupValue: _selectedMode,
                activeColor: Colors.black87,
                onChanged: _onModeChanged,
              ),
            ),
            SizedBox(height: 20),
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
                title: Text('${departmentDetails[UserDepartment.FacultyOfFineArts]!.emoji} Faculty of Fine Arts', style: GoogleFonts.lato()),
                value: departmentDetails[UserDepartment.FacultyOfFineArts]!.title,
                groupValue: _selectedMode,
                activeColor: Colors.black87,
                onChanged: _onModeChanged,
              ),
            ),
            SizedBox(height: 20),

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
                    updateDepartment(widget.documentId, _selectedMode!);
                    // Navigate to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AmicaeInterestScreen(documentId: widget.documentId)),
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