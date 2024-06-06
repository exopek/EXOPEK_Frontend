import 'package:exopek_workout_app/components/PlanDetailPage/PhaseInfoCard.dart';
import 'package:exopek_workout_app/components/WorkoutDetailPage/ExerciseInfoCard.dart';
import 'package:exopek_workout_app/domain/Models/Exercise.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenericSnackBar {
  static void showErrorSnackBar({
    required BuildContext context,
    required String text,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: ThemeBase.of(context).secondaryBackground,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Row(
        children: [
          const Icon(Icons.error, color: Colors.red),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: ThemeBase.of(context).bodySmall.copyWith(
                    color: ThemeBase.of(context).primaryText,
                    fontSize: 12,
                    height: 0,
                  ),
            ),
          ),
        ],
      ),
    ));
  }

  static void showSuccedSnackBar({
    required BuildContext context,
    required String text,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: ThemeBase.of(context).secondaryBackground,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Row(
        children: [
          const Icon(Icons.check, color: Colors.green),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: ThemeBase.of(context).bodySmall.copyWith(
                    color: ThemeBase.of(context).primaryText,
                    fontSize: 12,
                    height: 0,
                  ),
            ),
          ),
        ],
      ),
    ));
  }
}
