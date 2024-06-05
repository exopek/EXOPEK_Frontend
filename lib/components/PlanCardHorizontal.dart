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
      width: width ?? MediaQuery.of(context).size.width,
      height: 200,
      decoration: ShapeDecoration(
        image: DecorationImage( 
                    image: NetworkImage(planListItem.previewImageUrl),
                    fit: BoxFit.cover,
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
            left: 0,
            top: 0,
            child: Container(
              width: width ?? MediaQuery.of(context).size.width,
              height: 80,
              color: Colors.black.withOpacity(0.3),
            )),
          Positioned(
            left: 23,
            top: 16.23,
            child: SizedBox(
              height: 22.86,
              child: Text(
                planListItem.hashtagsStringWithHash.toString(),
                style: ThemeBase.of(context).bodySmall.copyWith(
                  color: ThemeBase.of(context).secondaryText,
                  fontSize: 10,
                  overflow: TextOverflow.ellipsis
                )
              ),
            ),
          ),
          Positioned(
            left: 23,
            top: 30,
            child: SizedBox(
              height: 36.19,
              child: Text(
                planListItem.name,
                style: ThemeBase.of(context).headlineSmall,
              ),
            ),
          ),
          Positioned(
            left: 23,
            top: 62,
            child: Row(
                children: [
                  CardInformationBlock(value: planListItem.duration.toString() + " Wochen", icon: Icons.watch,),
                ],
              ),
          ),
          Positioned(
            right: 22,
            top: 158,
            child: SizedBox(
              width: 140,
              child: CtaButton(
                fontSizeLable: 12,
                height: 32,
                label: 'Start Now',
                onPressed: () {},
              ),
            ),
          ),
          /* Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: width ?? MediaQuery.of(context).size.width,
              height: 80,
              color: Colors.black.withOpacity(0.4),
            )) */
        ],
      ),
    );
  }
}
