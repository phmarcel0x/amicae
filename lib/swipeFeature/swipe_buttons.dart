import 'package:flutter/material.dart';

class SwipeButton extends StatelessWidget {
  final VoidCallback? swipeAction;
  final Color? buttonColor;
  final IconData? buttonIcon;
  final Color? iconColor;

  SwipeButton(
      {this.swipeAction, this.buttonColor, this.buttonIcon, this.iconColor});

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
          // boxShadow: [
          //   BoxShadow(
          //       color: const Color.fromARGB(255, 0, 106, 4),
          //       blurRadius: 4,
          //       offset: Offset(0, 0))
          // ]
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
