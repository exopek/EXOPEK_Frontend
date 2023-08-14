import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:exopek_workout_app/data/repository/WorkoutRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../AppConfig.dart';

final dioProvider = Provider((ref) {
  Dio dio = Dio();
  dio.options.baseUrl = AppConfig.apiBaseUrl;
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
      HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
  // Set default configs
  return dio;
});

final dioWorkoutProvider = Provider<WorkoutRepository>((ref) {
  return WorkoutRepository(ref);
});
