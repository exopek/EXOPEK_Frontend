import 'package:flutter/material.dart';

class PlanBenefits extends StatelessWidget {
  final List<String> benefits;
  const PlanBenefits({super.key, required this.benefits});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
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
              height: 20,
              width: MediaQuery.of(context).size.width - 32,
              child: Stack(
                children: [
                  Positioned(
                    left: 29,
                    top: 3,
                    child: Text(
                      benefits[0],
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
              width: MediaQuery.of(context).size.width - 32,
              height: 20,
              child: Stack(
                children: [
                  Positioned(
                    left: 29,
                    top: 3,
                    child: Text(
                      benefits[1],
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
              width: MediaQuery.of(context).size.width - 32,
              height: 20,
              child: Stack(
                children: [
                  Positioned(
                    left: 29,
                    top: 3,
                    child: Text(
                      benefits[2],
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
              width: MediaQuery.of(context).size.width - 32,
              height: 20,
              child: Stack(
                children: [
                  Positioned(
                    left: 29,
                    top: 3,
                    child: Text(
                      benefits[3],
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
