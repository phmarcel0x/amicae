// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const ConnectionsPage());

class Match {
  final String name;
  final String image;
  final String message;

  Match({
    required this.name,
    required this.image,
    required this.message,
  });
}

class ConnectionsPage extends StatelessWidget {
  const ConnectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PeoplePage();
  }
}

class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  // Sample data for matches
  final List<Match> matches = [
    Match(
      name: 'Amicae Dev Team',
      image: 'assets/ae_short_black.png', // Fixed image path
      message: 'Welcome to Amicae! Complete your profile and start swiping!',
    ),
    // Add more sample matches as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Connections"),
        // backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false, // This removes the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: matches.isEmpty
            ? const Center(
          child: Text(
            'No currently matches, keep swiping!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
            : ListView.builder(
          itemCount: matches.length + 1, // Add 1 for the footer
          itemBuilder: (context, index) {
            if (index == matches.length) {
              // Display "Keep swiping!" message at the end
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Text(
                    'Keep swiping!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }

            final match = matches[index];
            return Card(
              color: Colors.white, // Ensures the background is not pink
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(match.image),
                ),
                title: Text(
                  match.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(match.message),
                trailing: const Icon(Icons.message_rounded, color: Colors.black),
                onTap: () {
                  // Navigate to the conversation page or similar
                },
              ),
            );
          },
        ),
      ),
    );
  }
}