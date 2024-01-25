import 'package:flutter/material.dart';

import '../../components/CtaButton.dart';
import '../../utils/AppRouter.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({super.key});

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 390,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
        child: Stack(
          children: [
            Positioned(
              left: 32,
              top: 44,
              child: Text(
                'Wir machen Dich',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 32,
              top: 84,
              child: Text(
                'zum EXOPEK-Mitglied.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 32,
              top: 494,
              child: Container(
                width: 26,
                height: 26,
                decoration: ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
            Positioned(
              left: 32,
              top: 591,
              child: Container(
                width: 26,
                height: 26,
                decoration: ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
            Positioned(
              left: 81,
              top: 494,
              child: SizedBox(
                width: 265,
                child: Text(
                  'Sign up for emails to get updates from EXOPEK on products, offers and your Memeber benefits.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 77,
              top: 591,
              child: SizedBox(
                width: 265,
                child: Text(
                  'I agree to EXOPEK’s Terms of Use and I confirm I have read EXOPEK’s Privacy Policy.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 32,
              top: 155,
              child: Container(
                width: 314,
                height: 67,
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
              left: 32,
              top: 404,
              child: Container(
                width: 314,
                height: 67,
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
              left: 32,
              top: 321,
              child: Container(
                width: 314,
                height: 67,
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
              left: 32,
              top: 238,
              child: Container(
                width: 151,
                height: 67,
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
              left: 195,
              top: 238,
              child: Container(
                width: 151,
                height: 67,
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
              left: 32,
              right: 32,
              top: 706,
              child: CtaButton(
                label: 'Weiter',
                onPressed: () {
                  AppRouter.goToRegisterSucceed();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
