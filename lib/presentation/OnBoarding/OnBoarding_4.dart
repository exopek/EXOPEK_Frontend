import 'package:flutter/material.dart';

import '../../components/CtaButton.dart';
import '../../utils/AppRouter.dart';

class OnBoarding4 extends StatefulWidget {
  const OnBoarding4({super.key});

  @override
  State<OnBoarding4> createState() => _OnBoarding4State();
}

class _OnBoarding4State extends State<OnBoarding4> {
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
              left: 38,
              top: 40,
              child: Container(
                  width: 84,
                  height: 64,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Container()),
            ),
            Positioned(
              left: 36,
              top: 133,
              child: SizedBox(
                width: 327,
                child: Text(
                  'Wie viel Zeit möchtest Du dem Training widmen?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 36,
              top: 228,
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
              right: 32,
              top: 700,
              child: CtaButton(
                label: 'Weiter',
                onPressed: () {
                  AppRouter.goToOnBoarding5();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
