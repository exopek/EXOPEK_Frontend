import 'package:exopek_workout_app/components/CardInformationBlock.dart';
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
      width: width ?? MediaQuery.of(context).size.width * 0.8,
      height: 200,
      decoration: ShapeDecoration(
        image: DecorationImage( 
                    image: NetworkImage(planListItem.previewImageUrl),
                    fit: BoxFit.fill,
                  ),
                color: Color(0x00262424),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF262424)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
      child: Stack(
        children: [
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
            top: 62,
            child: Row(
                children: [
                  CardInformationBlock(value: "20"),
                  const SizedBox(width: 10),
                  Container(
                        height: 12.05,
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 0.50,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(0xFF838282),
                            ),
                          ),
                        ),
                      ),
                  const SizedBox(width: 10),
                  CardInformationBlock(value: "20"),
                ],
              ),
          ),
          Positioned(
            right: 22,
            top: 158,
            child: Container(
              width: 140,
              child: CtaButton(
                fontSizeLable: 12,
                height: 32,
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
