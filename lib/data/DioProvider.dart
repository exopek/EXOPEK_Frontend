import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/data/repository/UserRepository.dart';
import 'package:exopek_workout_app/data/repository/WorkoutRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../AppConfig.dart';
import '../domain/Models/Workout.dart';

final dioProvider = Provider((ref) {
  Dio dio = Dio();
  dio.options.baseUrl = AppConfig.apiBaseUrl;
  /* (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
      HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true; */
  // Set default configs
  return dio;
});

final dioWorkoutProvider = Provider<WorkoutRepository>((ref) {
  return WorkoutRepository(ref);
});

final workoutProvider =
    FutureProvider.autoDispose<List<WorkoutListItem>>((ref) async {
  final data = await ref.watch(dioWorkoutProvider).getWorkouts();
  return data;
});

final workoutSingleProvider =
    FutureProvider.autoDispose<WorkoutDetails>((ref) async {
  final id = ref.read(selectedWorkoutIdProvider);
  final data = await ref.watch(dioWorkoutProvider).getWorkout(id);
  return data;
});

final combinedWorkoutProvider =
    FutureProvider.autoDispose<Map<String, List<WorkoutListItem>>>((ref) async {
  final data1 = await ref.watch(dioWorkoutProvider).getWorkouts();
  /* final data2 = await ref.watch(data2Provider.future);
  final data3 = await ref.watch(data3Provider.future); */

  //return data1 != null && data2 != null && data3 != null;
  final Map<String, List<WorkoutListItem>> result = {};
  result["workouts"] = data1;
  return result;
});
