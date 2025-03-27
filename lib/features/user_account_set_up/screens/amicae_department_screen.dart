import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/user_profile_service.dart';
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
  final _userProfileService = UserProfileService();
  UserDepartment? _selectedDepartment;
  bool isButtonEnabled = false;
  bool _isUpdating = false;

  void _onDepartmentChanged(UserDepartment? value) {
    setState(() {
      _selectedDepartment = value;
      isButtonEnabled = _selectedDepartment != null;
    });
  }

  Future<void> _updateDepartment() async {
    if (!isButtonEnabled || _isUpdating || _selectedDepartment == null) return;

    setState(() {
      _isUpdating = true;
    });

    try {
      await _userProfileService.updateDepartment(_selectedDepartment!);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AmicaeInterestScreen(documentId: widget.documentId),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update department: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }

  Widget _buildDepartmentTile(UserDepartment department) {
    final departmentInfo = departmentDetails[department]!;
    return Container(
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
      child: RadioListTile<UserDepartment>(
        title: Text('${departmentInfo.emoji} ${departmentInfo.title}',
            style: GoogleFonts.lato()),
        value: department,
        groupValue: _selectedDepartment,
        activeColor: Colors.black87,
        onChanged: _onDepartmentChanged,
      ),
    );
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
            const SizedBox(height: 10),
            Text(
              'This helps us connect you with peers in your field of study.',
              style: GoogleFonts.lato(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView(
                children: [
                  _buildDepartmentTile(UserDepartment.FacultyOfArtsAndScience),
                  const SizedBox(height: 20),
                  _buildDepartmentTile(
                      UserDepartment.JohnMolsonSchoolOfBusiness),
                  const SizedBox(height: 20),
                  _buildDepartmentTile(UserDepartment
                      .GinaCodySchoolOfEngineeringAndComputerScience),
                  const SizedBox(height: 20),
                  _buildDepartmentTile(UserDepartment.FacultyOfFineArts),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 28,
                child: IconButton(
                  icon: _isUpdating
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(
                          Icons.arrow_circle_right_sharp,
                          size: 50,
                          color: isButtonEnabled ? Colors.black : Colors.grey,
                        ),
                  onPressed: isButtonEnabled && !_isUpdating
                      ? _updateDepartment
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
