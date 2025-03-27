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
  final _userProfileService = UserProfileService();
  String? _selectedMode;
  bool isButtonEnabled = false;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    // Initialize button state (optional, as it's false by default)
  }

  void _onModeChanged(String? value) {
    setState(() {
      _selectedMode = value;
      isButtonEnabled = _selectedMode != null;
    });
  }

  Future<void> _updateMode() async {
    if (!isButtonEnabled || _isUpdating || _selectedMode == null) return;

    setState(() {
      _isUpdating = true;
    });

    try {
      await _userProfileService.updateLookingFor(_selectedMode!);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AmicaeEduStatusScreen(documentId: widget.documentId),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update mode: $error')),
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
              'Choose a mode to get started',
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Amicae\'s for making all kinds of connections! You\'ll be able to switch modes once you\'re all set up.',
              style: GoogleFonts.lato(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 40),
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
                title: Text('BFF', style: GoogleFonts.lato()),
                subtitle: Text('Make new friends at every stage of your life',
                    style: GoogleFonts.lato()),
                value: 'BFF',
                groupValue: _selectedMode,
                activeColor: Colors.black87,
                onChanged: _onModeChanged,
              ),
            ),
            const SizedBox(height: 20),
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
                subtitle: Text('Find that special connection in the community',
                    style: GoogleFonts.lato()),
                value: 'Mentor',
                groupValue: _selectedMode,
                activeColor: Colors.black87,
                onChanged: _onModeChanged,
              ),
            ),
            const Spacer(),
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
                  onPressed:
                      isButtonEnabled && !_isUpdating ? _updateMode : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
