import 'package:exopek_workout_app/domain/Models/Exercise.dart';
import 'package:flutter/material.dart';

class WorkoutOverviewCard extends StatelessWidget {
  final int round;
  final List<ExcerciseWorkoutConfig>? excerciseWorkoutConfig;
  final int stageType;

  const WorkoutOverviewCard(
      {super.key,
      required this.round,
      this.excerciseWorkoutConfig,
      required this.stageType});

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
                  side: BorderSide(width: 0.50, color: Color(0xFF262424)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: 7,
            top: 14,
            child: Text(
              'Runde ${round + 1}',
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
              excerciseWorkoutConfig!.first.stageTypeAsString as String,
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
              '${excerciseWorkoutConfig!.length} Übungen',
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
              child:
                  Icon(Icons.info_outline, size: 16, color: Colors.blue[700])),
        ],
      ),
    );
  }
}
