import 'package:exopek_workout_app/components/GenericBottomSheet.dart';
import 'package:exopek_workout_app/domain/Models/Exercise.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';

import '../domain/Models/Plan.dart';
import '../domain/Models/Workout.dart';

class PlanOverviewCard extends StatelessWidget {
  final int round;
  final PlanPhaseViewModel? planPhase;
  final int phaseType;
  final int currentPhaseType;
  final StatusType statusType;

  const PlanOverviewCard(
      {super.key,
      required this.round,
      this.planPhase,
      required this.currentPhaseType,
      required this.statusType,
      required this.phaseType});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 113,
        height: 119,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 113,
                height: 119,
                decoration: ShapeDecoration(
                  color: Color(0x00262424),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 0.50,
                        color: currentPhaseType == phaseType &&
                                statusType == StatusType.ACTIVE
                            ? ThemeBase.of(context).secondary
                            : Color(0xFF262424)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 7,
              top: 14,
              child: Text(
                'Phase ${round + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 7,
              top: 70,
              child: Text(
                planPhase!.workouts.first.phaseTypeAsString as String,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 7,
              top: 92,
              child: Text(
                '${planPhase!.workouts.length} Workouts',
                style: TextStyle(
                  color: Color(0xFF838282),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
                left: 89,
                top: 15,
                child: Icon(Icons.info_outline,
                        size: 16, color: Colors.blue[700]),
        )],
        ),
      );
    
  }
}
