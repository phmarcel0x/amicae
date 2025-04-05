import 'package:flutter/material.dart';

class SwipeButton extends StatelessWidget {
  final VoidCallback swipeAction;
  final Color buttonColor;
  final IconData buttonIcon;
  final Color iconColor;

  const SwipeButton({
    super.key,
    required this.swipeAction,
    required this.buttonColor,
    required this.buttonIcon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: swipeAction,
      child: Container(
        height: 72,
        width: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white, // White background
          border: Border.all(color: Colors.black, width: 3.0), // Black border
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FittedBox(
            child: Icon(
              buttonIcon,
              color: iconColor, // Default icon color to black
            ),
          ),
        ),
      ),
    );
  }
}