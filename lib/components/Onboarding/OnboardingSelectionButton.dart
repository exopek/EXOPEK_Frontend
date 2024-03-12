import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnboardingSelectionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function(bool) onTap;

  OnboardingSelectionButton({required this.text, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(!isSelected);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.red : Colors.white,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.red : Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}