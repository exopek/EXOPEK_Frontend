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
  Future<List<WorkoutListItem>> getWorkouts() async {
    Dio _dio = ref.watch(dioProvider);
    //_dio.options.baseUrl = _baseUrl;
    Response res = await _dio.get("workouts");
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
}
