import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';

class CardInformationBlock extends StatelessWidget {
  final String value;
  final IconData? icon;

  CardInformationBlock({required this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            icon ?? Icons.chat_bubble_rounded,
            color: ThemeBase.of(context).primaryText,
            size: 14,
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            value,
            style: ThemeBase.of(context).bodySmall.copyWith(
              color: ThemeBase.of(context).primaryText,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
