import 'package:flutter/material.dart';
import 'profiles_brain.dart';
import 'profile_card.dart';
import 'swipe_buttons.dart';

ProfilesBrain profilesBrain = ProfilesBrain();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SwipePage());
  }
}

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});
  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  buttonAction() {
    setState(() {
      profilesBrain.swipeProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ProfileCard(
                  profile: profilesBrain.users[profilesBrain.userNumber]),
            )),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SwipeButton(
                swipeAction: buttonAction,
                buttonColor: Colors.lightGreen,
                buttonIcon: Icons.favorite,
                iconColor: Colors.pinkAccent,
              ),
              SwipeButton(
                swipeAction: buttonAction,
                buttonColor: Colors.blueAccent,
                buttonIcon: Icons.close,
                iconColor: Colors.white60,
              )
            ],
          ),
        ),
      ],
    );
  }
}
