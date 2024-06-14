import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:exopek_workout_app/components/WorkoutLists/WorkoutLikeButtonController.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/data/repository/UserRepository.dart';
import 'package:exopek_workout_app/data/repository/WorkoutRepository.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../AppConfig.dart';
import '../domain/Models/Workout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final dioProvider = Provider((ref) {
  Dio dio = Dio();
  dio.options.baseUrl = AppConfig.apiBaseUrl;
  var localisation = ref.watch(localizationProvider);
  dio.options.headers["accept-language"] = localisation + "-" + localisation.toUpperCase();
  /* (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
      HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true; */
  // Set default configs
  dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
    return handler.next(options); //continue
  }, onResponse: (response, handler) {
    return handler.next(response); // continue
  }, onError: (DioException e, handler) {
    print(AppRouter.router.routeInformationProvider.value.uri.toString());
    if (e.response?.statusCode == 401) {
      switch (AppRouter.router.routeInformationProvider.value.uri.toString()) {
        case "/login":
          break;
        case "/onBoarding0":
          break;
        default:
          AppRouter.goToOnBoarding0();
          break;
      }
      
      return handler.resolve(Response(requestOptions: e.requestOptions, data: {"error": "Unauthorized"}));
    }
    
    return handler.next(e); //continue
  }));
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

final asyncWorkoutLikeButtonControllerProvider =
    AsyncNotifierProvider.autoDispose<WorkoutLikeButtonController, void>(
        () {
  return WorkoutLikeButtonController();
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
