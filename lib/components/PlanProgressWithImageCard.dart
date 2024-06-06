import 'package:exopek_workout_app/components/CardInformationBlock.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../domain/Models/Plan.dart';

class PlanProgressWithImageCard extends StatelessWidget {
  final PlanListItem plan;
  final PlanStatus planStatus;
  const PlanProgressWithImageCard(
      {super.key, required this.plan, required this.planStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 156,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF262424)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          // Image
          Container(
            width: 111.56,
            height: 156,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(plan.previewImageUrl),
                fit: BoxFit.cover,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
          ),

          // Trennstrich
          Container(
            width: 2,
            height: 156,
            color: ThemeBase.of(context).secondary,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hashtags
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.42,
                  child: Text(plan.hashtagsStringWithHash.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: ThemeBase.of(context).bodySmall.copyWith(
                          color: ThemeBase.of(context).secondaryText,
                          fontSize: 10,
                          overflow: TextOverflow.ellipsis)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(plan.name, style: ThemeBase.of(context).titleMedium),
                      const SizedBox(height: 2),
                      // Information Block

                      CardInformationBlock(
                        value: plan.duration.toString() + " wochen",
                        icon: _svgBt('Uhr',
                            height: 12.0,
                            width: 12.0,
                            color: ThemeBase.of(context).primaryText),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress bar
                    if (planStatus.progressPercentage != 100)
                      Container(
                        height: 10,
                        width: MediaQuery.sizeOf(context).width * 0.42,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFF262424)),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: MediaQuery.sizeOf(context).width *
                                    0.42 *
                                    planStatus.progressPercentage /
                                    100,
                                height: 8,
                                decoration: ShapeDecoration(
                                  color: ThemeBase.of(context).secondary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Progress text
                    if (planStatus.progressPercentage != 100)
                      SizedBox(
                        child: Text(
                            '${planStatus.progressPercentage}% Abgeschlossen',
                            style: ThemeBase.of(context).bodySmall.copyWith(
                                  color: ThemeBase.of(context).secondaryText,
                                  fontSize: 10,
                                  height: 0,
                                )),
                      ),
                    if (planStatus.progressPercentage == 100)
                      Text(
                          "Plan Abgeschlossen: " +
                              planStatus.createdAt.toString().split("T")[0],
                          style: ThemeBase.of(context).bodySmall.copyWith(
                              color: ThemeBase.of(context).secondaryText,
                              fontSize: 10,
                              height: 0)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget _svgBt(String assetBasename,
          {Color color = const Color(0xFF838282),
          double width = 20,
          double height = 20,
          VoidCallback? onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: SvgPicture.asset(
            'assets/svg/$assetBasename.svg',
            color: color,
            width: width,
            height: height,
          ),
        ),
      );
}
