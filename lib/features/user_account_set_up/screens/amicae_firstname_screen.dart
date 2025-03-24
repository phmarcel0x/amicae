import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/user_profile_service.dart';
import '../screens/amicae_description_screen.dart';

class AmicaeFirstNameScreen extends StatefulWidget {
  const AmicaeFirstNameScreen({super.key, required this.documentId});

  final String documentId;

  @override
  _AmicaeFirstNameScreenState createState() => _AmicaeFirstNameScreenState();
}

class _AmicaeFirstNameScreenState extends State<AmicaeFirstNameScreen> {
  final TextEditingController _controller = TextEditingController();
  final _userProfileService = UserProfileService();
  bool isButtonEnabled = false;
  bool _isUpdating = false;

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

  Future<void> _updateFirstName() async {
    if (!isButtonEnabled || _isUpdating) return;

    setState(() {
      _isUpdating = true;
    });

    try {
      await _userProfileService.updateFirstName(_controller.text.trim());

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AmicaeDescriptionScreen(documentId: widget.documentId),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update first name: $error')),
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
            const SizedBox(height: 40),
            Text(
              "What's your first name?",
              style: GoogleFonts.lato(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "We won't be able to change this later.",
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Add your first name",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(
                  Icons.remove_red_eye,
                  color: Colors.black,
                  size: 20.0,
                ),
                const SizedBox(width: 4.0),
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
                        ? _updateFirstName
                        : null,
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
