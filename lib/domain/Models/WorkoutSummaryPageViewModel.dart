import 'package:exopek_workout_app/domain/Models/Plan.dart';

import 'Workout.dart';

class WorkoutSummaryPageViewModel {
  WorkoutDetails workoutDetails;
  PlanStatus? planStatus;
  String? planWorkoutId;
  WorkoutSummaryPageViewModel(
      {required this.workoutDetails, this.planStatus, this.planWorkoutId});
}
