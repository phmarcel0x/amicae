// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:http/http.dart' as http;
//
// // import 'package:amicae_v5/screens/amicae_profile_picture_screen.dart';
// import '../screens/amicae_department_screen.dart';
//
// import '../models/user_edu_status.dart';
// import '../data/education_status.dart';
//
// class AmicaeEduStatusScreen extends StatefulWidget {
//   const AmicaeEduStatusScreen({super.key, required this.documentId});
//
//   final String documentId;
//
//   @override
//   State<AmicaeEduStatusScreen> createState() => _AmicaeEduStatusScreenState();
// }
//
// class _AmicaeEduStatusScreenState extends State<AmicaeEduStatusScreen> {
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
//   Future<void> updateEduStatus(String documentId, String selectedMode) async {
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
//         body: json.encode({'eduStatus': selectedMode}), // Sending the mode as JSON
//       );
//
//       if (response.statusCode == 200) {
//         print('Education Status updated successfully!');
//       } else {
//         print('Failed to update education status: ${response.statusCode}');
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
//               'Choose your education status',
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
//                 title: Text('${educationStatusMap[EducationStatus.InCollege]!.emoji} In college', style: GoogleFonts.lato()),
//                 value: educationStatusMap[EducationStatus.InCollege]!.title,
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
//                 title: Text('${educationStatusMap[EducationStatus.University]!.emoji} University', style: GoogleFonts.lato()),
//                 value: educationStatusMap[EducationStatus.University]!.title,
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
//                 title: Text('${educationStatusMap[EducationStatus.JustGraduated]!.emoji} Just Graduated', style: GoogleFonts.lato()),
//                 value: educationStatusMap[EducationStatus.JustGraduated]!.title,
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
//                 title: Text('${educationStatusMap[EducationStatus.GettingBackIntoEducation]!.emoji} Getting back into education', style: GoogleFonts.lato()),
//                 value: educationStatusMap[EducationStatus.GettingBackIntoEducation]!.title,
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
//                 title: Text('${educationStatusMap[EducationStatus.WorkingAndStudying]!.emoji} Working and Studying', style: GoogleFonts.lato()),
//                 value: educationStatusMap[EducationStatus.WorkingAndStudying]!.title,
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
//                 title: Text('${educationStatusMap[EducationStatus.PostgradDegree]!.emoji} Post graduation degree', style: GoogleFonts.lato()),
//                 value: educationStatusMap[EducationStatus.PostgradDegree]!.title,
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
//                 title: Text('${educationStatusMap[EducationStatus.GapYear]!.emoji} Gap Year', style: GoogleFonts.lato()),
//                 value: educationStatusMap[EducationStatus.GapYear]!.title,
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
//                     updateEduStatus(widget.documentId, _selectedMode!);
//                     // Handle forward button press
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => AmicaeDepartmentScreen(documentId: widget.documentId)),
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

import '../services/user_profile_service.dart';
import '../screens/amicae_department_screen.dart';

import '../models/user_edu_status.dart';
import '../data/education_status.dart';

class AmicaeEduStatusScreen extends StatefulWidget {
  const AmicaeEduStatusScreen({super.key, required this.documentId});

  final String documentId;

  @override
  State<AmicaeEduStatusScreen> createState() => _AmicaeEduStatusScreenState();
}

class _AmicaeEduStatusScreenState extends State<AmicaeEduStatusScreen> {
  final UserProfileService _userProfileService = UserProfileService();

  EducationStatus? _selectedMode;
  bool isButtonEnabled = false;

  void _onModeChanged(EducationStatus? value) {
    setState(() {
      _selectedMode = value;
      isButtonEnabled = _selectedMode != null;
    });
  }

  Future<void> _updateEduStatus() async {
    if (_selectedMode == null) return;

    try {
      final formattedEduStatus = "${educationStatusMap[_selectedMode]!.emoji} ${educationStatusMap[_selectedMode]!.title}";

      await _userProfileService.updateProfileField('educationStatus', formattedEduStatus);

      // Navigate to next screen
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AmicaeDepartmentScreen(documentId: widget.documentId)
        ),
      );
    } catch (error) {
      // Show error dialog or snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update education status: $error'),
          backgroundColor: Colors.red,
        ),
      );
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
              'Choose your education status',
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
            Expanded(child: ListView(children: [

            // Generate radio buttons dynamically
            ...EducationStatus.values.map((status) => Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
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
                child: RadioListTile<EducationStatus>(
                  title: Text(
                      '${educationStatusMap[status]!.emoji} ${educationStatusMap[status]!.title}',
                      style: GoogleFonts.lato()
                  ),
                  value: status,
                  groupValue: _selectedMode,
                  activeColor: Colors.black87,
                  onChanged: _onModeChanged,
                ),
              ),
            )).toList(),
            ],)),


            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 28,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_circle_right_sharp,
                    size: 50,
                    color: isButtonEnabled ? Colors.black : Colors.grey,
                  ),
                  onPressed: isButtonEnabled ? _updateEduStatus : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}