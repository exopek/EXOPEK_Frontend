import 'package:exopek_workout_app/domain/Models/ViewModels/WorkoutDetailPageViewModel.dart';
import 'package:exopek_workout_app/presentation/WorkoutDetails/WorkoutDetailPageController.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final asyncWorkoutDetailPageControllerProvider = AsyncNotifierProvider.autoDispose<WorkoutDetailPageController, WorkoutDetailPageViewModel> (() {
  return WorkoutDetailPageController();
});