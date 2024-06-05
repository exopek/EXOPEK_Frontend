import 'package:dio/dio.dart';
import 'package:exopek_workout_app/data/contracts/IPlanRepository.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/utils/AppUtil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/Models/Plan.dart';
import '../DioProvider.dart';

class PlanRepository implements IPlanRepository {
  PlanRepository(this.ref);

  final Ref ref;

  @override
  Future<PlanDetails> getPlan(String id) async {
    Dio _dio = ref.watch(dioProvider);

    Response res = await _dio.get("plans/${id}");
    print(res.data.runtimeType);
    if (res.statusCode == 200) {
      var plan = PlanDetails.fromJson(res.data as Map<String, dynamic>);
      return plan;
    } else {
      throw Exception("Failed to load plan");
    }
  }

  @override
  Future<List<PlanListItem>> getPlans({Map<String, String>? query}) async {
    Dio _dio = ref.watch(dioProvider);
    String queryString = "";
    if (query != null) {
      queryString = "?" + getQueryString(query);
    }
    Response res = await _dio.get("plans${queryString}");
    if (res.statusCode == 200) {
      var plans = (res.data as List<dynamic>)
          .map((w) => PlanListItem.fromJson(w as Map<String, dynamic>))
          .toList() as List<PlanListItem>;
      ;
      return plans; //compute(_parseWorkouts, res.data);
    } else {
      throw Exception("Failed to load plans");
    }
  }

  @override
  Future<List<PlanStatus>> getPlanStatuses(
      {String? planId, StatusType? status = StatusType.ACTIVE}) async {
    Dio _dio = ref.watch(dioProvider);

    String queryString = "?";

    if (planId != null) {
      queryString += "planId=${planId}";
    }
    if (status != null) {
      queryString += "&status=${status.index}";
    }
    // Need userId
    Response res = await _dio.get("plans/status${queryString}");
    if (res.statusCode == 200) {
      var statuses = (res.data as List<dynamic>)
          .map((w) => PlanStatus.fromJson(w as Map<String, dynamic>))
          .toList() as List<PlanStatus>;
      ;
      return statuses;
    } else {
      throw Exception("Failed to load plan statuses");
    }
  }

  @override
  Future<bool> startPlan(String planId, String userId) async {
    Dio _dio = ref.watch(dioProvider);

    Response res = await _dio.post("plans/status", data: {
      "planId": planId,
    });

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to start plan");
    }
  }

  @override
  Future<bool> stopPlan(String id) async {
    Dio _dio = ref.watch(dioProvider);

    Response res = await _dio
        .put("plans/status", data: {"id": id, "status": 0, "currentPhase": 0});

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to start plan");
    }
  }

  @override
  Future<bool> updatePlanStatus(
      {required String id,
      required StatusType status,
      required PhaseType phase,
      required List<String> workoutIds}) async {
    Dio _dio = ref.watch(dioProvider);

    Response res = await _dio.put("plans/status", data: {
      "id": id,
      "status": status.index,
      "currentPhase": phase.index,
      "planWorkoutIds": workoutIds
    });

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to update plan");
    }
  }
}
