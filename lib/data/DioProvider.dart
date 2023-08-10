


import 'package:dio/dio.dart';
import 'package:exopek_workout_app/data/repository/WorkoutRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((ref) {
  Dio dio = Dio();
  // Set default configs
  return dio;
});

final dioWorkoutProvider = Provider<WorkoutRepository>((ref) {
  
  return WorkoutRepository(ref);
});