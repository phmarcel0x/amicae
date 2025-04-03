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
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: buttonColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Icon(
            buttonIcon,
            color: iconColor,
            size: 66,
          ),
        ),
      ),
    );
  }
}
