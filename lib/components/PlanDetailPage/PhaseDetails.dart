import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';

class PhaseDetails extends StatelessWidget {
  final String title;
  final List<WorkoutPlanConfig> workoutPlanConfig; 
  const PhaseDetails({super.key, required this.title, required this.workoutPlanConfig});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: ThemeBase.of(context).headlineSmall.copyWith(
              fontSize: 18.0
            ),
          ),
        ),
        for (var workout in workoutPlanConfig)
          _workoutRow(context, workout),
        Divider(color: ThemeBase.of(context).secondaryText, thickness: 0.5, ),
      ],
    );
  }

  Widget _workoutRow(BuildContext context, WorkoutPlanConfig workout) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 8.0),
          SizedBox(
            width: 20,
            height: 20,
            child: Icon(Icons.flaky_sharp,
                color: ThemeBase.of(context).secondary, size: 20),
          ),
          const SizedBox(width: 8.0),
          Expanded(child: Text(workout.name, style: ThemeBase.of(context).bodySmall.copyWith(color: ThemeBase.of(context).secondaryText))),
        ],
      ),
    );
  }
}