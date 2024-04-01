import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/domain/Models/WorkoutComplete.dart';

class ProfilPageViewModel {
  List<WorkoutCompleteReadDto> workouts = [];
  final User user;

  ProfilPageViewModel({required this.workouts, required this.user});
} 