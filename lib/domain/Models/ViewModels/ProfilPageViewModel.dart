import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/domain/Models/WorkoutComplete.dart';

class ProfilPageViewModel {
  List<WorkoutCompleteReadDto> workouts = [];
  final User user;
  List<PlanListItem> plans = [];
  List<PlanStatus> planStatuses = [];

  ProfilPageViewModel({required this.workouts, required this.user, required this.plans, required this.planStatuses});
} 