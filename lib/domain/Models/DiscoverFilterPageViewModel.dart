import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';

class DiscoverFilterPageViewModel {
  List<PlanListItem> plans = [];
  List<WorkoutListItem> workouts = [];

  DiscoverFilterPageViewModel({required this.plans, required this.workouts});
}
