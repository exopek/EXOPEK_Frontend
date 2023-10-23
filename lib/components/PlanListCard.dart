import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:flutter/material.dart';

class PlanListCard extends StatelessWidget {
  final PlanListItem planListItem;

  const PlanListCard({super.key, required this.planListItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 456,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 330,
              height: 456,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(planListItem.previewImageUrl),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: 13,
            top: 345,
            child: SizedBox(
              width: 230,
              height: 46,
              child: Text(
                planListItem.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 13,
            top: 402,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: planListItem.hashtagsStringWithHash.toString(),
                    style: TextStyle(
                      color: Color(
                          0xFF838282), // Muss nachher eine AppColor werden
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: '  ',
                    style: TextStyle(
                      color: Color(0xFF838282),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      height: 0,
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
