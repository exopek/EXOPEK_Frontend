import 'Plan.dart';
import 'Workout.dart';

class CoachPageViewModel {
  List<PlanListItem> plans = [];
  List<WorkoutListItem> workouts = [];
  List<PlanListItem> startedPlans = [];
  List<PlanStatus> planStatuses = [];

  CoachPageViewModel(
      {required this.plans,
      required this.workouts,
      required this.startedPlans,
      required this.planStatuses});
}
