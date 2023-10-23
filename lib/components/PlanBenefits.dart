import 'package:flutter/material.dart';

class PlanBenefits extends StatelessWidget {
  const PlanBenefits({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 194,
      height: 135,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Text(
              'Das ist für dich drin:',
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
            left: 16,
            top: 31,
            child: Container(
              width: 178,
              height: 20,
              child: Stack(
                children: [
                  Positioned(
                    left: 29,
                    top: 3,
                    child: Text(
                      'Garantierte Verbesserte Fitness',
                      style: TextStyle(
                        color: Color(0xFF838282),
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      child: Icon(Icons.check_box_outlined,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 59,
            child: Container(
              width: 127,
              height: 20,
              child: Stack(
                children: [
                  Positioned(
                    left: 29,
                    top: 3,
                    child: Text(
                      '4-wöchiges Program',
                      style: TextStyle(
                        color: Color(0xFF838282),
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      child: Icon(Icons.check_box_outlined,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 87,
            child: Container(
              width: 178,
              height: 20,
              child: Stack(
                children: [
                  Positioned(
                    left: 29,
                    top: 3,
                    child: Text(
                      'Garantierte Verbesserte Fitness',
                      style: TextStyle(
                        color: Color(0xFF838282),
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      child: Icon(Icons.check_box_outlined,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 115,
            child: Container(
              width: 178,
              height: 20,
              child: Stack(
                children: [
                  Positioned(
                    left: 29,
                    top: 3,
                    child: Text(
                      'Garantierte Verbesserte Fitness',
                      style: TextStyle(
                        color: Color(0xFF838282),
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      child: Icon(Icons.check_box_outlined,
                          color: Colors.white, size: 20),
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
