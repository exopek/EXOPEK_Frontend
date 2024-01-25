import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:flutter/material.dart';

class PlanProgressCard extends StatelessWidget {
  const PlanProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 358,
              height: 220,
              decoration: ShapeDecoration(
                color: Color(0x00262323),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF262424)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Positioned(
            left: 22.78,
            top: 18,
            child: SizedBox(
              width: 240.84,
              height: 32,
              child: Text(
                'Functional Plan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 22.78,
            top: 61,
            child: SizedBox(
              width: 312.44,
              height: 19,
              child: Text(
                '12 Trainings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 22.78,
            top: 108,
            child: SizedBox(
              width: 312.44,
              height: 19,
              child: Text(
                '2 / 12 trainings has been finished',
                style: TextStyle(
                  color: Color(0xFF828282),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 22.78,
            top: 91,
            child: Container(
              width: 312.44,
              height: 10,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 312.44,
                      height: 10,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFF262424)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 46.93,
                      height: 10,
                      decoration: ShapeDecoration(
                        color: Color(0xFFCE2323),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFF262424)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              left: 170,
              top: 169,
              child: SizedBox(
                width: 160,
                child: CtaButton(
                  label: "Start Now",
                  height: 29,
                  fontSizeLable: 12,
                ),
              )),
        ],
      ),
    );
  }
}
