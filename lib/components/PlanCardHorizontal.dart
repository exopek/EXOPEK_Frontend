import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';

class PlanCardHorizontal extends StatelessWidget {
  final PlanListItem planListItem;
  final double? width;
  const PlanCardHorizontal({super.key, required this.planListItem, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.srcOver),
              child: Container(
                width: width ?? MediaQuery.of(context).size.width * 0.9,
                height: 200,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(planListItem.previewImageUrl),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 23,
            top: 58,
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
                                "4",
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
          Positioned(
            left: 23,
            top: 34,
            child: SizedBox(
              height: 36.19,
              child: Text(
                planListItem.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 23,
            top: 19.23,
            child: SizedBox(
              height: 22.86,
              child: Text(
                planListItem.hashtagsStringWithHash.toString(),
                style: TextStyle(
                  color: Color(0xFF838282),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: width ?? MediaQuery.of(context).size.width * 0.9,
              height: 200,
              decoration: ShapeDecoration(
                color: Color(0x00262424),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF262424)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: 180,
            top: 158,
            child: Container(
              width: 140,
              child: CtaButton(
                fontSizeLable: 12,
                height: 28,
                label: 'Start Now',
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
