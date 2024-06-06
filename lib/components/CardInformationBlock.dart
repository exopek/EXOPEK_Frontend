import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardInformationBlock extends StatelessWidget {
  final String value;
  final Widget icon;

  CardInformationBlock({required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon,
        const SizedBox(
          width: 5,
        ),
        Text(
          value,
          style: ThemeBase.of(context).bodySmall.copyWith(
                color: ThemeBase.of(context).primaryText,
                fontSize: 10,
              ),
        ),
      ],
    );
  }

  static Widget _svgBt(String assetBasename, VoidCallback onTap,
          {Color color = const Color(0xFF838282),
          double width = 20,
          double height = 20}) =>
      GestureDetector(
        //padding: EdgeInsets.zero,
        onTap: onTap,
        //iconSize: width > height ? width : height,
        //constraints: BoxConstraints.tightFor(width: width, height: height),
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
