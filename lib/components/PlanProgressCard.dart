import 'package:flutter/material.dart';

class PlanProgressCard extends StatelessWidget {
  const PlanProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 139,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 326,
              height: 139,
              decoration: ShapeDecoration(
                color: Color(0xFF262323),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Positioned(
            left: 21,
            top: 18,
            child: SizedBox(
              width: 222,
              height: 32,
              child: Text(
                'Functional Plan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            left: 21,
            top: 61,
            child: SizedBox(
              width: 288,
              height: 19,
              child: Text(
                '12 Trainings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            left: 21,
            top: 108,
            child: SizedBox(
              width: 288,
              height: 19,
              child: Text(
                '2 / 12 trainings has been finished',
                style: TextStyle(
                  color: Color(0xFF828282),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            left: 21,
            top: 91,
            child: Container(
              width: 288,
              height: 10,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 288,
                      height: 10,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 117,
                      height: 10,
                      decoration: ShapeDecoration(
                        color: Color(0xFFCE2323),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
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
