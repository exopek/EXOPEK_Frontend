import 'package:exopek_workout_app/domain/Models/Comment.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/domain/Models/WorkoutComplete.dart';

import '../Plan.dart';

class WorkoutDetailPageViewModel {
  final WorkoutDetails workout;
  final List<Comment> comments;

  WorkoutDetailPageViewModel({required this.workout, required this.comments});
}
