import 'package:flutter/material.dart';

import '../../components/CtaButton.dart';
import '../../utils/AppRouter.dart';

class OnBoarding6 extends StatefulWidget {
  const OnBoarding6({super.key});

  @override
  State<OnBoarding6> createState() => _OnBoarding6State();
}

class _OnBoarding6State extends State<OnBoarding6> {
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
                  'Wie groß bist Du?',
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
                  AppRouter.goToMainPage();
                },
              ),
            ),
            Positioned(
              left: 38,
              top: 204,
              child: Text(
                'Körpergröße (cm)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
