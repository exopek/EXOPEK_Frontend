import 'package:flutter/material.dart';

class SettingsCtaButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Icon? icon;
  final Color? color;
  const SettingsCtaButton(
      {super.key, required this.title, this.onPressed, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        decoration: BoxDecoration(
          color: Color(0x00D9D9D9),
          border: Border(
            bottom: BorderSide(width: 1, color: Color(0xFF262424)),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 14,
              child: SizedBox(
                height: 25.50,
                child: Text(
                  title,
                  style: TextStyle(
                    color: color ?? Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            if (icon != null) Positioned(right: 26, top: 8, child: icon!)
          ],
        ),
      ),
    );
  }
}
