import 'package:dio/dio.dart';
import 'package:exopek_workout_app/domain/Models/Enums/DifficultyType.dart';

import '../../domain/Models/Enums/PhaseType.dart';
import '../../domain/Models/Plan.dart';
import '../../domain/Models/Workout.dart';

abstract class IPlanRepository {
  Future<List<dynamic>> getPlans({Map<String, String>? query});
  Future<dynamic> getPlan(String id, {Map<String, String>? query});
  Future<List<dynamic>> getPlanStatuses({String? planId, StatusType? status});
  Future<bool> startPlan(String planId, DifficultyType difficultyType);
  Future<bool> stopPlan(String id);
  Future<bool> updatePlanStatus(
      {required String id,
      required StatusType status,
      required PhaseType phase,
      required List<String> workoutIds});
}
