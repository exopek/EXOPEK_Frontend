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
    //_dio.options.baseUrl = _baseUrl;
    Response res = await _dio.get("plans/byId?id=$id");
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
      throw Exception("Failed to load workouts");
    }
  }
}
