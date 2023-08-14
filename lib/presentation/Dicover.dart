import 'package:flutter/material.dart';

import '../components/SearchBarCustom.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  TextEditingController? _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 844,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 390,
              height: 128,
              decoration: BoxDecoration(color: Color(0xFF262424)),
            ),
          ),
          Positioned(
            left: 16,
            top: 43,
            child: Container(
              width: 105,
              height: 21,
              decoration: ShapeDecoration(
                color: Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 77,
            child: SearchBarCustom(controller: _searchController, xsize: 0.8),
          ),
          Positioned(
            left: 16,
            top: 150,
            child: SizedBox(
              width: 124,
              height: 27,
              child: Text(
                'Trending',
                style: TextStyle(
                  color: Color(0xFF838282),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            left: 19,
            top: 390,
            child: SizedBox(
              width: 124,
              height: 27,
              child: Text(
                'Quick - Burner',
                style: TextStyle(
                  color: Color(0xFF838282),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            left: 19,
            top: 184,
            child: Container(
              width: 291.08,
              height: 199,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 291.08,
                      height: 199,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://via.placeholder.com/291x199"),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 17.12,
                    top: 139.52,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Functional Basic\n',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: '29 - 43 MIN. - GANZER KÖRPER - 125 PUNKTE',
                            style: TextStyle(
                              color: Color(0xFF838282),
                              fontSize: 10,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 265.96,
                    top: 12.44,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: ShapeDecoration(
                        color: Color(0xFF0E68EE),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 422,
            child: Container(
              width: 164,
              height: 263,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 164,
                      height: 263,
                      decoration: ShapeDecoration(
                        color: Color(0xFF262424),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 164,
                      height: 206,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://via.placeholder.com/164x206"),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 206,
                    child: Container(
                      width: 164,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFD31919),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 142.56,
                    top: 14.17,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: ShapeDecoration(
                        color: Color(0xFFEE0EE5),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 9.65,
                    top: 157.49,
                    child: SizedBox(
                      width: 135.06,
                      height: 29.92,
                      child: Text(
                        'Core and Burn',
                        style: TextStyle(
                          color: Color(0xFFFFFDFD),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    top: 218,
                    child: Container(
                      width: 152.21,
                      height: 31.50,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 152.21,
                              height: 31.50,
                              decoration:
                                  BoxDecoration(color: Color(0x00D9D9D9)),
                            ),
                          ),
                          Positioned(
                            left: 3.56,
                            top: 3.15,
                            child: Container(
                              width: 41.57,
                              height: 23.62,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 13.35,
                                      height: 23.62,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://via.placeholder.com/13x24"),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 16.91,
                                    top: 1.57,
                                    child: SizedBox(
                                      width: 24.65,
                                      height: 18.90,
                                      child: Text(
                                        '20 m',
                                        style: TextStyle(
                                          color: Color(0xFF0C0C0C),
                                          fontSize: 10,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 66.46,
                            top: 3.15,
                            child: Container(
                              width: 41.57,
                              height: 23.62,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 13.35,
                                      height: 23.62,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://via.placeholder.com/13x24"),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 16.91,
                                    top: 1.57,
                                    child: SizedBox(
                                      width: 24.65,
                                      height: 18.90,
                                      child: Text(
                                        '20 m',
                                        style: TextStyle(
                                          color: Color(0xFF0C0C0C),
                                          fontSize: 10,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 53.59,
                            top: 4.72,
                            child: Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, 0.0)
                                ..rotateZ(1.57),
                              child: Container(
                                width: 22.05,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.50,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: Color(0xFF0C0C0C),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 137.97,
                            top: 4.72,
                            child: Container(
                              width: 13.35,
                              height: 23.62,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://via.placeholder.com/13x24"),
                                  fit: BoxFit.contain,
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
            ),
          ),
          Positioned(
            left: 0,
            top: 764,
            child: Container(
              width: 390,
              height: 80,
              decoration: BoxDecoration(color: Color(0xFF262323)),
            ),
          ),
        ],
      ),
    );
  }
}
