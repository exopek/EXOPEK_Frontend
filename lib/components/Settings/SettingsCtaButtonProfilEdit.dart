import 'package:flutter/material.dart';

class SettingsCtaButtonProfilEdit extends StatelessWidget {
  final String userName;
  final VoidCallback? onPressed;
  const SettingsCtaButtonProfilEdit(
      {super.key, required this.userName, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          color: Color(0xFF0C0C0C),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 80,
                height: 80,
                decoration: ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 100,
              top: 23,
              child: Text(
                userName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 100,
              top: 42,
              child: Text(
                'Profil bearbeiten',
                style: TextStyle(
                  color: Color(0xFF838282),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              right: 26,
              top: 30,
              child: Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
