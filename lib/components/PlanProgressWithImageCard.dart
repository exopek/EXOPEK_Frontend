import 'package:exopek_workout_app/components/CardInformationBlock.dart';
import 'package:flutter/material.dart';

import '../domain/Models/Plan.dart';

class PlanProgressWithImageCard extends StatelessWidget {
  final PlanListItem plan;
  final PlanStatus planStatus;
  const PlanProgressWithImageCard(
      {super.key, required this.plan, required this.planStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 156,
      decoration: ShapeDecoration(
                color: Color(0x00262424),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF262424)),
                  borderRadius: BorderRadius.circular(10),
                ),
                
              ),
      child: Stack(
        children: [
          // Image
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 111.56,
              height: 156,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage("${plan.previewImageUrl}"),
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
          ),
          // Trennstrich
          Positioned(
            left: 111.56,
            top: 1,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(1.57),
              child: Container(
                width: 154,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFFD31919),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Progress bar
          Positioned(
            left: 125.90,
            top: 128,
            child: Container(
              height: 10,
              width: 172,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 172,
                      height: 10,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color.fromARGB(255, 181, 156, 156)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 172 * planStatus.progressPercentage / 100,
                      height: 10,
                      decoration: ShapeDecoration(
                        color: Color(0xFFCE2323),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Progress text
          Positioned(
            left: 125.90,
            top: 108,
            child: SizedBox(
              child: Text(
                '${planStatus.progressPercentage}% Completed',
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
          // Information Block
          Positioned(
            left: 122.81,
            top: 55,
            child: Container(
              width: 150.26,
              height: 46.80,
              child: Stack(
                children: [
                  
                  Positioned(
                    left: 3.52,
                    top: 4.68,
                    child: CardInformationBlock(
                      value: plan.duration.toString() + " weeks",
                      icon: Icons.watch,
                    )
                  ),
                  /* Positioned(
                    left: 65.61,
                    top: 4.68,
                    child: CardInformationBlock(
                      value: plan.duration.toString(),
                    )
                  ), */
                  /* Positioned(
                    left: 52.91,
                    top: 6.02,
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
                  ), */
                ],
              ),
            ),
          ),
          // Name
          Positioned(
            left: 125.90,
            top: 33,
            child: SizedBox(
              height: 28.23,
              child: Text(
                plan.name,
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
          // Hashtags
          Positioned(
            left: 125.90,
            top: 15,
            child: SizedBox(
              height: 17.83,
              child: Text(
                plan.hashtagsStringWithHash.toString(),
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
        ],
      ),
    );
  }
}
