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
      final formattedEduStatus =
          "${educationStatusMap[_selectedMode]!.emoji} ${educationStatusMap[_selectedMode]!.title}";

      await _userProfileService
          .updateProfileField('educationStatus', formattedEduStatus);

      // Navigate to next screen
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AmicaeDepartmentScreen(documentId: widget.documentId)),
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              'Choose your education status',
              style: GoogleFonts.lato(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'You’ll be able to connect with people from all kinds of educational backgrounds.',
              style: GoogleFonts.lato(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 40),

            // Replace Expanded and ListView with a direct Column
            Column(
              children: [
                ...EducationStatus.values.map((status) => Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
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
                          style: GoogleFonts.lato()),
                      value: status,
                      groupValue: _selectedMode,
                      activeColor: Colors.black87,
                      onChanged: _onModeChanged,
                    ),
                  ),
                ))
              ],
            ),
            const Spacer(), // Push the button to the bottom
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: CircleAvatar(
            //     backgroundColor: Colors.white,
            //     radius: 28,
            //     child: IconButton(
            //       icon: Icon(
            //         Icons.arrow_circle_right_sharp,
            //         size: 50,
            //         color: isButtonEnabled ? Colors.black : Colors.grey,
            //       ),
            //       onPressed: isButtonEnabled ? _updateEduStatus : null,
            //     ),
            //   ),
            // ),
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Colors.black,
                  size: 20.0,
                ),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    'You can change your mode later in settings.',
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
                          color: isButtonEnabled ? Colors.black : Colors.grey,
                        ),
                        onPressed: isButtonEnabled ? _updateEduStatus : null,
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