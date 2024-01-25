import 'dart:convert';

import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/data/contracts/IWorkoutRepository.dart';
import 'package:exopek_workout_app/presentation/Workouts.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/Models/Workout.dart';

class WorkoutRepository implements IWorkoutRepository {
  WorkoutRepository(this.ref);

  final Ref ref;
  //final String _baseUrl = "http://exopek.azurewebsites.net/api/";

  @override
  Future<List<WorkoutListItem>> getWorkouts({String? query}) async {
    Dio _dio = ref.watch(dioProvider);
    //_dio.options.baseUrl = _baseUrl;
    String queryString = "";
    if (query == "All" || query == null) {
      query = "";
    }
    queryString = query!.isNotEmpty ? "?searchTerm=${query}" : "";
    Response res = await _dio.get("workouts${queryString}");
    if (res.statusCode == 200) {
      //var workouts = Workout.fromJson(res.data);
      var workouts = (res.data as List<dynamic>)
          .map((w) => WorkoutListItem.fromJson(w as Map<String, dynamic>))
          .toList() as List<WorkoutListItem>;
      ;
      return workouts; //compute(_parseWorkouts, res.data);
    } else {
      throw Exception("Failed to load workouts");
    }
  }

  @override
  Future<WorkoutDetails> getWorkout(String id) async {
    Dio _dio = ref.watch(dioProvider);
    //_dio.options.baseUrl = _baseUrl;
    Response res = await _dio.get("workouts/byId?id=$id");
    print(res.data.runtimeType);
    if (res.statusCode == 200) {
      var workout = WorkoutDetails.fromJson(res.data as Map<String, dynamic>);
      return workout;
    } else {
      throw Exception("Failed to load workout");
    }
  }

  @override
  Future<bool> completeWorkout({required String workoutId}) async {
    Dio _dio = ref.watch(dioProvider);

    Response res = await _dio.post("workouts/completes", data: {
      "workoutId": workoutId,
      "userId": "1c974964-9c9c-4674-84f5-bb34caddaf99"
    });
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to complete workout");
    }
  }
}
