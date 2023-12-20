import 'package:dio/dio.dart';
import 'package:exopek_workout_app/data/contracts/IPlanRepository.dart';
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
  Future<List<PlanListItem>> getPlans() async {
    Dio _dio = ref.watch(dioProvider);

    Response res = await _dio.get("plans");
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
  Future<List<PlanStatus>> getPlanStatuses(String id) async {
    Dio _dio = ref.watch(dioProvider);

    // Need userId
    Response res = await _dio.get(
        "plans/status?status=1&planId=${id}&userId=1c974964-9c9c-4674-84f5-bb34caddaf99");
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
      "userId": "1c974964-9c9c-4674-84f5-bb34caddaf99",
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
}
