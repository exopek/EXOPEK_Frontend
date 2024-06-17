import 'package:exopek_workout_app/components/CardInformationBlock.dart';
import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF262424)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.42,
                child: Text(planListItem.hashtagsStringWithHash.toString(),
                    style: ThemeBase.of(context).bodySmall.copyWith(
                        color: ThemeBase.of(context).secondaryText,
                        fontSize: 10,
                        overflow: TextOverflow.ellipsis)),
              ),
              Text(
                planListItem.name,
                style: ThemeBase.of(context).headlineSmall,
              ),
              CardInformationBlock(
                value: planListItem.duration.toString() + " ${AppLocalizations.of(context).planCardHorizontalDuration}",
                icon: _svgBt('Uhr',
                    height: 12.0,
                    width: 12.0,
                    color: ThemeBase.of(context).primaryText),
              ),
              const SizedBox(
                height: 60.0,
              ),
              SizedBox(
                width: 140,
                child: CtaButton(
                  fontSizeLable: 12,
                  height: 32,
                  label: AppLocalizations.of(context).planCardHorizontalButton,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _svgBt(String assetBasename,
          {Color color = Colors.white,
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
