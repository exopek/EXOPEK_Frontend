import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ExerciseInfoCard extends StatelessWidget {
  final String name;
  final String sets;
  final String duration;
  const ExerciseInfoCard({super.key, required this.name, required this.sets, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 106,
      height: 159,
      child: Stack(
        children: [
          Positioned(
            left: 1,
            top: 0,
            child: Container(
              width: 105,
              height: 159,
              decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFF262424)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: -10,
            top: -10,
            child: SvgPicture.asset(
          'assets/images/exstbi.svg',
          color: Colors.white,
          width: 90,
          height: 90,
        ),),
          Positioned(
            left: 0,
            top: 85,
            child: SizedBox(
              width: 105,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF838282),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 5,
            top: 131,
            child: Text(
              '${sets} Set',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF838282),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 70,
            top: 131,
            child: Text(
              '${duration}s',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF838282),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _svgBt(String assetBasename, VoidCallback onTap,
          {Color color = Colors.white,
          double width = 28,
          double height = 28}) =>
      GestureDetector(
        //padding: EdgeInsets.zero,
        onTap: onTap,
        //iconSize: width > height ? width : height,
        //constraints: BoxConstraints.tightFor(width: width, height: height),
        child: SvgPicture.asset(
          'assets/images/icons/svg/$assetBasename.svg',
          color: color,
          width: width,
          height: height,
        ),
      );
}
