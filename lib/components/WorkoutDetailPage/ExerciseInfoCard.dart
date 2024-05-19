import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ExerciseInfoCard extends StatelessWidget {
  final String name;
  final String sets;
  final String duration;
  final String imageUrl;
  const ExerciseInfoCard({super.key, required this.name, required this.sets, required this.duration, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 106,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: ThemeBase.of(context).secondaryText),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 106,
          height: 50,
          decoration: ShapeDecoration(
            color: ThemeBase.of(context).primary.withOpacity(0.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
          child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: ThemeBase.of(context).titleSmall.copyWith(
                    color: ThemeBase.of(context).secondaryText,
                    fontSize: 16,
                    height: 0,
                  ),
                ),
        ),
      )/* Stack(
        children: [
          
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
      ), */
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
