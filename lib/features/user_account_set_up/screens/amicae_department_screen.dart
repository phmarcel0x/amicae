import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/amicae_interest_screen.dart';
import '../services/user_profile_service.dart';

import '../models/user_department.dart';
import '../data/departments.dart';

class AmicaeDepartmentScreen extends StatefulWidget {
  const AmicaeDepartmentScreen({super.key, required this.documentId});

  final String documentId;

  @override
  State<AmicaeDepartmentScreen> createState() => _AmicaeDepartmentScreenState();
}

class _AmicaeDepartmentScreenState extends State<AmicaeDepartmentScreen> {
  final UserProfileService _userProfileService = UserProfileService();
  UserDepartment? _selectedDepartment;
  bool isButtonEnabled = false;

  void _onDepartmentChanged(String? value) {
    if (value != null) {
      final department = UserDepartment.values.firstWhere(
            (dept) => departmentDetails[dept]!.title == value,
      );

      setState(() {
        _selectedDepartment = department;
        isButtonEnabled = true;
      });
    }
  }

  Future<void> _updateDepartment() async {
    if (_selectedDepartment != null) {
      try {
        final formattedDepartment = "${departmentDetails[_selectedDepartment]!.emoji} ${departmentDetails[_selectedDepartment]!.title}";

        // Using updateProfileField directly to update with formatted string
        await _userProfileService.updateProfileField('department', formattedDepartment);

        // Navigate to the next screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AmicaeInterestScreen(documentId: widget.documentId)),
        );
      } catch (error) {
        // Show error dialog or snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update department: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
              'Choose your department',
              style: GoogleFonts.lato(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Amicae connects you across departments! Select yours to start making connections.',
              style: GoogleFonts.lato(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 40),

            // Department selection radio tiles
            ...UserDepartment.values.map((department) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
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
                  child: RadioListTile<String>(
                    title: Text(
                        '${departmentDetails[department]!.emoji} ${departmentDetails[department]!.title}',
                        style: GoogleFonts.lato()
                    ),
                    value: departmentDetails[department]!.title,
                    groupValue: _selectedDepartment != null
                        ? departmentDetails[_selectedDepartment]!.title
                        : null,
                    activeColor: Colors.black87,
                    onChanged: _onDepartmentChanged,
                  ),
                ),
              );
            }),

            const Spacer(),
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
                  onPressed: isButtonEnabled ? _updateDepartment : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}