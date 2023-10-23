import 'package:exopek_workout_app/components/GenericBottomSheet.dart';
import 'package:exopek_workout_app/domain/Models/Exercise.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';

import '../domain/Models/Workout.dart';

class PlanOverviewCard extends StatelessWidget {
  final int round;
  final List<WorkoutPlanConfig>? workoutPlanConfig;
  final int phaseType;
  final int currentPhaseType;

  const PlanOverviewCard(
      {super.key,
      required this.round,
      this.workoutPlanConfig,
      required this.currentPhaseType,
      required this.phaseType});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (currentPhaseType == phaseType) {
          AppRouter.goToPlanPhase(workoutPlanConfig!);
        }
      },
      child: Container(
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
                        color: currentPhaseType == phaseType
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
                workoutPlanConfig!.first.phaseTypeAsString as String,
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
                '${workoutPlanConfig!.length} Workouts',
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
                child: GestureDetector(
                    // hat kein internes Padding reagiert aber wesentlich schlecht als onPressed vom Button
                    onTap: () => GenericBottomSheet.show(
                        context: context,
                        items: workoutPlanConfig!.map((e) => e).toList()),
                    child: Icon(Icons.info_outline,
                        size: 16, color: Colors.blue[700]))),
          ],
        ),
      ),
    );
  }
}
