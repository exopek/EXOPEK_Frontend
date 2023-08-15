import 'dart:math';

import 'package:dio/dio.dart';
import 'package:exopek_workout_app/AppConfig.dart';
import 'package:exopek_workout_app/components/WorkoutCard.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/presentation/Dicover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/repository/WorkoutRepository.dart';

void main() {
  /* final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  return WorkoutRepository(dio);
}); */
  print(AppConfig.apiBaseUrl);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:
          const Discover(), //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
