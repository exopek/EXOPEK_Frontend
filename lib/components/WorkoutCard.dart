//import 'dart:js_interop';

import 'package:flutter/material.dart';

import '../domain/Models/Workout.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({super.key, required this.workout});

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  borderRadius: BorderRadius.circular(10),
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
                  image: NetworkImage(workout.previewImageUrl),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
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
            left: 10,
            top: 214,
            child: SizedBox(
              width: 135.06,
              height: 29.92,
              child: Text(
                workout.name,
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
            left: 6,
            top: 236,
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
                      decoration: BoxDecoration(color: Color(0x00D9D9D9)),
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
                              width: 14,
                              height: 14,
                              child: Icon(
                                Icons.watch_later_outlined,
                                color: Color(0xFF838282),
                                size: 14.00,
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
                                  color: Color(0xFF838282),
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
                            child: const SizedBox(
                              width: 14,
                              height: 14,
                              child: const Icon(
                                Icons.favorite_border,
                                color: Color(0xFF838282),
                                size: 14.00,
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
                                  color: Color(0xFF838282),
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
                    top: 2.72,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(1.57),
                      child: Container(
                        width: 16.05,
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
                    left: 135,
                    top: 3,
                    child: Container(
                        width: 14,
                        height: 14,
                        child: Icon(
                          Icons.info_outline,
                          color: Color(0xFF0C0C0C),
                          size: 14.00,
                        )),
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
