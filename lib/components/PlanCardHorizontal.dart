import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';

class PlanCardHorizontal extends StatelessWidget {
  const PlanCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 220,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 330,
              height: 220,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/330x220"),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Positioned(
            left: 17,
            top: 158,
            child: Text(
              'Functional Basic',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Positioned(
            left: 17,
            top: 121,
            child: SizedBox(
              width: 123,
              height: 16,
              child: Text(
                'Nächstes Workout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            left: 17,
            top: 189,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '#POWER  #POWER  #POWER  #POWER  #POWER',
                    style: TextStyle(
                      color: Color(0xFF838282),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextSpan(
                    text: '  ',
                    style: TextStyle(
                      color: Color(0xFF838282),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 225,
            top: 0,
            child: Container(
              width: 103,
              height: 44,
              child: Stack(
                children: [
                  Positioned(
                    left: 34,
                    top: 12,
                    child: SizedBox(
                      width: 57,
                      height: 20,
                      child: Text(
                        '13.1k',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
