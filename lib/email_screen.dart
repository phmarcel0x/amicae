import 'package:flutter/material.dart';
import 'home_screen.dart';

// void main() {
//   runApp(EmailRecoveryApp());
// }
//
// class EmailRecoveryApp extends StatelessWidget {
//   const EmailRecoveryApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: EmailRecoveryScreen(),
//     );
//   }
// }

class EmailRecoveryScreen extends StatelessWidget {
  const EmailRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.white,
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40), // Space from top
            Text(
              "What's your email address?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "We use this to recover your account if you can't log in.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                hintText: "Add recovery email",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Handle skip action
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 28,
                  child: IconButton(
                    icon: Icon(Icons.arrow_circle_right_sharp, size: 50, color: Colors.black),
                    onPressed: () {
                      // Handle forward button press
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
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
