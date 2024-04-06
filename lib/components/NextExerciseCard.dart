import 'package:flutter/material.dart';

class NextExerciseCard extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final String exerciseFrequenceType;

  const NextExerciseCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.exerciseFrequenceType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 323,
      height: 77,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 323,
              height: 77,
              decoration: ShapeDecoration(
                color: Color(0x00D9D9D9),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFF262424)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          if (imageUrl != null)
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 77,
                height: 77,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.50, color: Color(0xFF262424)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          if (imageUrl == null)
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 77,
                height: 77,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.50, color: Color(0xFF262424)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.greenAccent,
                    size: 40,
                  ),
                ),
              ),
            ),
          Positioned(
            left: 88,
            top: 15,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            left: 88,
            top: 39,
            child: Text(
              exerciseFrequenceType,
              style: TextStyle(
                color: Color(0xFF838282),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
