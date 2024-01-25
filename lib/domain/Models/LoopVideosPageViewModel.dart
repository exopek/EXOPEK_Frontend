import 'package:exopek_workout_app/domain/Models/Plan.dart';

import 'Workout.dart';

class LoopVideosPageViewModel {
  final PlanStatus? planStatus;
  final WorkoutDetails workoutDetails;
  final String? planWorkoutId;

  LoopVideosPageViewModel(
      {this.planStatus, required this.workoutDetails, this.planWorkoutId});
}
