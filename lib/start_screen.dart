import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'amicae_profile_picture_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/ae_short_white.png',
            width: 300,
            // color: const Color.fromARGB(150, 255, 255, 255),
          ),
          const SizedBox(height: 80),
          Text(
            'Connecting peers to peers',
            style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 0, 0, 0), fontSize: 24),
          ),
          const SizedBox(height: 80),
          OutlinedButton.icon(
            // onPressed: startQuiz,
            onPressed: () {
              Navigator.push(
                context,
                  MaterialPageRoute(builder: (context) => AmicaeProfilePictureScreen())
              );
            },
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white),
            icon: const Icon(Icons.person),
            label: const Text(
              'Start building',
            ),
          ),
        ],
      ),
    );
  }
// Widget build(BuildContext context) {
//   return Center(
//     child: Text('Text data')
//   );
// }
}
