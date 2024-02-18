import 'dart:math';

import 'package:dio/dio.dart';
import 'package:exopek_workout_app/AppConfig.dart';
import 'package:exopek_workout_app/components/WorkoutCard.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/presentation/Discover/Dicover.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/repository/WorkoutRepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print(AppConfig.apiBaseUrl);
  await ThemeBase.initialize();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'Flutter Demo',
      theme: ThemeData(
        /* androidOverscrollIndicator: AndroidOverscrollIndicator.stretch, */
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
