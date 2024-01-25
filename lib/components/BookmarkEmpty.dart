import 'package:flutter/material.dart';

class BookmarkEmpty extends StatelessWidget {
  const BookmarkEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 344,
      height: 155,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 344,
              height: 155,
              decoration: ShapeDecoration(
                color: Color(0x00D9D9D9),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF262424)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: 25,
            top: 120,
            child: Text(
              'Save your favorite Workouts',
              style: TextStyle(
                color: Color(0xFF838282),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
