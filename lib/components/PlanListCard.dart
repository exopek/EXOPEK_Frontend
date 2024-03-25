import 'package:exopek_workout_app/components/VideoPlayers/VisibleListVideoPlayer.dart';
import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:flutter/material.dart';

class PlanListCard extends StatelessWidget {
  final PlanListItem planListItem;

  const PlanListCard({super.key, required this.planListItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: 290,
        height: 516,
        decoration: ShapeDecoration(
          color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: 516,
                width: 290,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: VisibleListVideoPlayer(
                    path: planListItem.videoUrl,
                    videoKey: planListItem.id,
                    lazyLoad: false,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: 516,
                width: 290,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFF262424)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 0,
                top: 345,
                child: Container(
                  width: 330,
                  height: 111,
                  decoration: ShapeDecoration(
                    color: Color(0xFF262424).withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          planListItem.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          planListItem.hashtagsStringWithHash.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(
                                0xFF838282), // Muss nachher eine AppColor werden
                            fontSize: 10,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w300,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
