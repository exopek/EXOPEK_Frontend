import 'package:exopek_workout_app/domain/Models/User.dart';

import '../Plan.dart';
import '../Workout.dart';

class CoachPageViewModel {
  List<PlanListItem> plans = [];
  List<WorkoutListItem> workouts = [];
  List<PlanListItem> startedPlans = [];
  List<PlanStatus> planStatuses = [];
  final ReadUserDto user;

  CoachPageViewModel(
      {required this.plans,
      required this.workouts,
      required this.startedPlans,
      required this.planStatuses,
      required this.user});
}
