import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:flutter/material.dart';

class WorkoutCardHorizontal extends StatelessWidget {
  final WorkoutListItem workout;
  final bool hasTrained;

  const WorkoutCardHorizontal(
      {super.key, required this.workout, this.hasTrained = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 105,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
                width: MediaQuery.sizeOf(context).width * 0.9,
                height: 105,
                decoration: ShapeDecoration(
                  //color: Color(0xFF262424),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        //width: 1.5,
                        //strokeAlign: BorderSide.strokeAlignCenter,
                        color:
                            hasTrained ? Color(0xFFD31919) : Color(0xFF262424)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 108.10,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(workout.previewImageUrl),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                )),
          ),
          Positioned(
            left: 122,
            top: 38,
            child: Text(
              workout.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 108.10,
            top: 0,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(1.57),
              child: Container(
                width: 105,
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
          ),
          Positioned(
            left: 122,
            top: 20,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width - 180,
              child: Text(
                workout.hashtagsStringWithHash as String,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  color: Color(0xFF838282),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Positioned(
            left: 119,
            top: 70,
            child: Container(
              width: MediaQuery.of(context).size.width - 32,
              height: 31.50,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 145.61,
                      height: 31.50,
                      decoration: BoxDecoration(color: Color(0x00D9D9D9)),
                    ),
                  ),
                  Positioned(
                    left: 3.41,
                    top: 3.15,
                    child: Container(
                      width: 39.76,
                      height: 23.62,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Icon(
                              Icons.access_time,
                              color: Color(0xFF838282),
                              size: 14,
                            ),
                          ),
                          Positioned(
                            left: 16.18,
                            top: 1.57,
                            child: SizedBox(
                              width: 23.58,
                              height: 18.90,
                              child: Text(
                                workout.durationString as String,
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
                    left: 63.58,
                    top: 3.15,
                    child: Container(
                      width: 39.76,
                      height: 23.62,
                      child: Stack(
                        children: [
                          Positioned(
                              left: 0,
                              top: 0,
                              child: Icon(
                                Icons.favorite_border,
                                color: Color(0xFF838282),
                                size: 14,
                              ) /* Container(
                              width: 12.77,
                              height: 23.62,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://via.placeholder.com/13x24"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ), */
                              ),
                          Positioned(
                            left: 16.18,
                            top: 1.57,
                            child: SizedBox(
                              width: 23.58,
                              height: 18.90,
                              child: Text(
                                '100k',
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
                    left: 51.27,
                    top: 4.72,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(1.57),
                      child: Container(
                        width: 12.05,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 0.50,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(0xFF838282),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 142.0,
                      top: 3,
                      child: Icon(
                        Icons.more_vert_rounded,
                        color: Color(0xFF838282),
                        size: 14,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
