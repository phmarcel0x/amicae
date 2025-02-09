import 'package:flutter/material.dart';
import 'email_screen.dart';

class YourLifeScreen extends StatefulWidget {
  const YourLifeScreen({super.key});

  @override
  State<YourLifeScreen> createState() => _YourLifeScreenState();
}

class _YourLifeScreenState extends State<YourLifeScreen> {
  // Map to track which buttons are selected
  Map<String, bool> selectedOptions = {
    "New to town": false,
    "Living abroad": false,
    "Moved country": false,
    "Travelling": false,
    "In college": false,
    "University": false,
    "Just graduated": false,
    "Getting back into education": false,
    "Working and studying": false,
    "Postgrad degree": false,
    "Gap year": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Your Life'),
        leading: BackButton(),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 600,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pick up to 3 to find friends with shared experiences.',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ToggleSwitch(),
                    SizedBox(height: 20),
                    buildCategory("Travel", [
                      "New to town",
                      "Living abroad",
                      "Moved country",
                      "Travelling",
                    ]),
                    // SizedBox(height: 20),
                    // buildCategory("Travel", [
                    //   "New to town",
                    //   "Living abroad",
                    //   "Moved country",
                    //   "Travelling",
                    // ]),
                    // SizedBox(height: 20),
                    // buildCategory("Travel", [
                    //   "New to town",
                    //   "Living abroad",
                    //   "Moved country",
                    //   "Travelling",
                    // ]),
                    SizedBox(height: 20),
                    buildCategory("Education", [
                      "In college",
                      "University",
                      "Just graduated",
                      "Getting back into education",
                      "Working and studying",
                      "Postgrad degree",
                      "Gap year",
                    ]),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(26.5),
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  icon: Icon(Icons.arrow_circle_right_sharp, size: 50, color: Colors.black),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmailRecoveryScreen()),
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategory(String category, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Wrap(
          runSpacing: 10,
          spacing: 10,
          children: options.map((option) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  // Toggle the button state
                  selectedOptions[option] = !(selectedOptions[option] ?? false);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: selectedOptions[option]==true ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: selectedOptions[option]==true ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
class ToggleSwitch extends StatefulWidget {
  @override
  _ToggleSwitchState createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: isToggled,
          onChanged: (value) {
            setState(() {
              isToggled = value;
            });
          },
        ),
        Text('Shown on my profile'),
      ],
    );
  }
}
