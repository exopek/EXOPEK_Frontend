import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/domain/Models/Like.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/WorkoutDetailPageViewModel.dart';
import 'package:exopek_workout_app/presentation/WorkoutDetails/WorkoutDetailPageController.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final asyncWorkoutDetailPageControllerProvider = AsyncNotifierProvider.autoDispose<WorkoutDetailPageController, WorkoutDetailPageViewModel> (() {
  return WorkoutDetailPageController();
});

final asyncLikedWorkoutsProvider =
    FutureProvider.autoDispose<List<LikeReadDto>>((ref) async {
  final workoutRepository = ref.read(dioWorkoutProvider);
  final data = await workoutRepository.getWorkoutLikes();
  return data;
});