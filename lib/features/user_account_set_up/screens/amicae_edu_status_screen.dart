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
  final _userProfileService = UserProfileService();
  EducationStatus? _selectedStatus;
  bool isButtonEnabled = false;
  bool _isUpdating = false;

  void _onStatusChanged(EducationStatus? value) {
    setState(() {
      _selectedStatus = value;
      isButtonEnabled = _selectedStatus != null;
    });
  }

  Future<void> _updateEducationStatus() async {
    if (!isButtonEnabled || _isUpdating || _selectedStatus == null) return;

    setState(() {
      _isUpdating = true;
    });

    try {
      await _userProfileService.updateEducationStatus(_selectedStatus!);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AmicaeDepartmentScreen(documentId: widget.documentId),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update education status: $error')),
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

  Widget _buildStatusTile(EducationStatus status) {
    final statusInfo = educationStatusMap[status]!;
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
      child: RadioListTile<EducationStatus>(
        title: Text('${statusInfo.emoji} ${statusInfo.title}',
            style: GoogleFonts.lato()),
        value: status,
        groupValue: _selectedStatus,
        activeColor: Colors.black87,
        onChanged: _onStatusChanged,
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
              'Choose your education status',
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'This helps us connect you with peers in similar academic situations.',
              style: GoogleFonts.lato(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView(
                children: [
                  _buildStatusTile(EducationStatus.InCollege),
                  const SizedBox(height: 20),
                  _buildStatusTile(EducationStatus.University),
                  const SizedBox(height: 20),
                  _buildStatusTile(EducationStatus.JustGraduated),
                  const SizedBox(height: 20),
                  _buildStatusTile(EducationStatus.GettingBackIntoEducation),
                  const SizedBox(height: 20),
                  _buildStatusTile(EducationStatus.WorkingAndStudying),
                  const SizedBox(height: 20),
                  _buildStatusTile(EducationStatus.PostgradDegree),
                  const SizedBox(height: 20),
                  _buildStatusTile(EducationStatus.GapYear),
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
                      ? _updateEducationStatus
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
