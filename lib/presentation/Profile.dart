import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: 390,
        height: 1310,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
        child: Stack(
          children: [
            Positioned(
              left: 143,
              top: 51,
              child: Container(
                width: 100,
                height: 100,
                decoration: ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 23,
              top: 180,
              child: Text(
                'Level 1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 23,
              top: 222,
              child: Text(
                '1050 Punkte',
                style: TextStyle(
                  color: Color(0xFF838282),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 248,
              top: 222,
              child: Text(
                '1050 Punkte bis Level 2',
                style: TextStyle(
                  color: Color(0xFF838282),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 23,
              top: 208,
              child: Container(
                width: 340,
                height: 10,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 340,
                        height: 10,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFF262424)),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 138.12,
                        height: 10,
                        decoration: ShapeDecoration(
                          color: Color(0xFFCE2323),
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFF262424)),
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
              left: 0,
              top: 321,
              child: Container(
                width: 390,
                height: 464,
                decoration: BoxDecoration(color: Color(0xFF212326)),
              ),
            ),
            Positioned(
              left: 90,
              top: 347,
              child: Container(
                width: 209,
                height: 196,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/209x196"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 38,
              top: 593,
              child: Container(
                width: 309,
                height: 43,
                decoration: BoxDecoration(color: Color(0x00D9D9D9)),
              ),
            ),
            Positioned(
              left: 37,
              top: 556,
              child: Container(
                width: 326,
                height: 24,
                child: Stack(
                  children: [
                    Positioned(
                      left: 1,
                      top: 0,
                      child: SizedBox(
                        width: 39,
                        height: 12.49,
                        child: Text(
                          'Core',
                          style: TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 262,
                      top: 0,
                      child: SizedBox(
                        width: 27,
                        height: 12.49,
                        child: Text(
                          '7 %',
                          style: TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 24,
                      child: Container(
                        width: 326,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 37,
              top: 591,
              child: Container(
                width: 326,
                height: 24,
                child: Stack(
                  children: [
                    Positioned(
                      left: 1,
                      top: 0,
                      child: SizedBox(
                        width: 39,
                        height: 12.49,
                        child: Text(
                          'Back',
                          style: TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 262,
                      top: 0,
                      child: SizedBox(
                        width: 27,
                        height: 12.49,
                        child: Text(
                          '7 %',
                          style: TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 24,
                      child: Container(
                        width: 326,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 37,
              top: 626,
              child: Container(
                width: 326,
                height: 24,
                child: Stack(
                  children: [
                    Positioned(
                      left: 1,
                      top: 0,
                      child: SizedBox(
                        width: 64,
                        height: 12,
                        child: Text(
                          'Bizepts',
                          style: TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 262,
                      top: 0,
                      child: SizedBox(
                        width: 27,
                        height: 12.49,
                        child: Text(
                          '7 %',
                          style: TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 24,
                      child: Container(
                        width: 326,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 37,
              top: 661,
              child: Container(
                width: 326,
                height: 24,
                child: Stack(
                  children: [
                    Positioned(
                      left: 1,
                      top: 0,
                      child: SizedBox(
                        width: 64,
                        height: 12,
                        child: Text(
                          'Chest',
                          style: TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 262,
                      top: 0,
                      child: SizedBox(
                        width: 27,
                        height: 12.49,
                        child: Text(
                          '7 %',
                          style: TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 24,
                      child: Container(
                        width: 326,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 38,
              top: 696,
              child: Container(
                width: 326,
                height: 24,
                child: Stack(
                  children: [
                    Positioned(
                      left: 1,
                      top: 0,
                      child: SizedBox(
                        width: 64,
                        height: 12,
                        child: Text(
                          'Chest',
                          style: TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 262,
                      top: 0,
                      child: SizedBox(
                        width: 27,
                        height: 12.49,
                        child: Text(
                          '7 %',
                          style: TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 24,
                      child: Container(
                        width: 326,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 37,
              top: 731,
              child: Container(
                width: 326,
                height: 24,
                child: Stack(
                  children: [
                    Positioned(
                      left: 1,
                      top: 0,
                      child: SizedBox(
                        width: 64,
                        height: 12,
                        child: Text(
                          'Chest',
                          style: TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 262,
                      top: 0,
                      child: SizedBox(
                        width: 27,
                        height: 12.49,
                        child: Text(
                          '7 %',
                          style: TextStyle(
                            color: Color(0xFF0C0C0C),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 24,
                      child: Container(
                        width: 326,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 23,
              top: 22,
              child: Text(
                'Jan Sugint',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 23,
              top: 45,
              child: Text(
                'EXOPEK Athlet Stufe 1',
                style: TextStyle(
                  color: Color(0xFF838282),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 31,
              top: 285,
              child: SizedBox(
                width: 60,
                height: 16.72,
                child: Text(
                  'Activity',
                  style: TextStyle(
                    color: Color(0xFFF4F1F1),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 118,
              top: 285,
              child: SizedBox(
                width: 111,
                height: 16.72,
                child: Text(
                  'Achievmensts',
                  style: TextStyle(
                    color: Color(0xFFF4F1F1),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 346,
              top: 26,
              child: Container(
                width: 24,
                height: 19,
                decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
