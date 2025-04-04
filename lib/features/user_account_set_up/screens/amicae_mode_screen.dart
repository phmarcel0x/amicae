import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/user_profile_service.dart';
import '../screens/amicae_edu_status_screen.dart';

class AmicaeModeScreen extends StatefulWidget {
  const AmicaeModeScreen({super.key, required this.documentId});

  final String documentId;

  @override
  _AmicaeModeScreenState createState() => _AmicaeModeScreenState();
}

class _AmicaeModeScreenState extends State<AmicaeModeScreen> {
  final UserProfileService _profileService = UserProfileService();
  String? _selectedMode;
  bool isButtonEnabled = false;
  bool _isUpdating = false;

  void _onModeChanged(String? value) {
    setState(() {
      _selectedMode = value;
      isButtonEnabled = _selectedMode != null;
    });
  }

  Future<void> _updateMode() async {
    if (!isButtonEnabled || _isUpdating) return;

    setState(() {
      _isUpdating = true;
    });

    try {
      await _profileService.updateLookingFor(_selectedMode!);
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AmicaeEduStatusScreen(documentId: widget.documentId),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update mode: $error'),
            backgroundColor: Colors.red,
          ),
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

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'Choose a mode to get started',
                        style: GoogleFonts.lato(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Amicae is for making all kinds of connections!',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // BFF option
                      Container(
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
                          title: Text('Friend / Study Buddy', style: GoogleFonts.lato()),
                          subtitle: Text(
                            'Make new friends at every stage of your life',
                            style: GoogleFonts.lato(),
                          ),
                          value: 'Friend / Study Buddy',
                          groupValue: _selectedMode,
                          activeColor: Colors.black87,
                          onChanged: _onModeChanged,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Mentor option
                      Container(
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
                          title: Text('Mentor', style: GoogleFonts.lato()),
                          subtitle: Text(
                            'Find that special connection in the community',
                            style: GoogleFonts.lato(),
                          ),
                          value: 'Mentor',
                          groupValue: _selectedMode,
                          activeColor: Colors.black87,
                          onChanged: _onModeChanged,

                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                      onPressed: isButtonEnabled && !_isUpdating ? _updateMode : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}