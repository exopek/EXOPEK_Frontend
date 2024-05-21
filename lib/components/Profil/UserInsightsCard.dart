import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';

class UserInsightsCard extends StatelessWidget {
  final String insightName;
  final String insightValue;
  const UserInsightsCard({super.key, required this.insightName, required this.insightValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              color: Color(0xFF262424)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 16.0),
            child: Container(
              width: 30,
              height: 30,
              decoration: ShapeDecoration(
                shape: const OvalBorder(),
                color: ThemeBase.of(context).secondary,
              ),
              child: const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                insightValue,
                style: ThemeBase.of(context).titleMedium.copyWith(
                  color: ThemeBase.of(context).primaryText,
                )
              ),
              Text(
                insightName,
                style: ThemeBase.of(context).titleSmall.copyWith(
                  color: ThemeBase.of(context).secondaryText,
                  fontSize: 12.0
                )
              ),
              const SizedBox(height: 10),
            ]),
        ],
      ),
    );
  }
}