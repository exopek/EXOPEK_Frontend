import 'package:dio/dio.dart';

abstract class IPlanRepository {
  Future<List<dynamic>> getPlans();
  Future<dynamic> getPlan(String id);
  Future<List<dynamic>> getPlanStatuses(String id);
  Future<bool> startPlan(String planId, String userId);
  Future<bool> stopPlan(String id);
}
