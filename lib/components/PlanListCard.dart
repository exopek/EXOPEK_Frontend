import 'package:exopek_workout_app/components/HashTagPill.dart';
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
                top: 375,
                child: Container(
                  width: 290,
                  height: 140,
                  decoration: ShapeDecoration(
                    color: Color(0xFF262424).withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                        child: Text(
                          "Mit diesem Plan baust du Kraft und Ausdauer auf. Meistere jeden Wiederstand.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 12.0, bottom: 8.0, right: 8.0),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (var hashtag
                                in (planListItem.hashtagsList as List<String>).take(3))
                              IntrinsicWidth(
                                  child: HashTagPill(
                                text: hashtag,
                                color: Color(0xFF262424),
                              ))
                          ],
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
