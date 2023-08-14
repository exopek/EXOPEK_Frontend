import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/data/contracts/IWorkoutRepository.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/Models/Workout.dart';

class WorkoutRepository implements IWorkoutRepository {
  WorkoutRepository(this.ref);

  final Ref ref;
  //final String _baseUrl = "http://exopek.azurewebsites.net/api/";

  @override
  Future<List<Workout>> getWorkouts() async {
    Dio _dio = ref.watch(dioProvider);
    //_dio.options.baseUrl = _baseUrl;
    Response res = await _dio.get("workouts");
    if (res.statusCode == 200) {
      //var workouts = Workout.fromJson(res.data);
      var workouts = res.data.map<Workout>((w) => Workout.fromJson(w)).toList();
      return workouts; //compute(_parseWorkouts, res.data);
    } else {
      throw Exception("Failed to load workouts");
    }
  }
}
