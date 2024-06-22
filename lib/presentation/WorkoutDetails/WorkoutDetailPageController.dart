import 'dart:async';

import 'package:exopek_workout_app/dependencyInjection/workoutProvider/WorkoutProvider.dart';
import 'package:exopek_workout_app/domain/Models/Enums/DifficultyType.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/AppStateProvider.dart';
import '../../data/DioProvider.dart';
import '../../domain/Models/ViewModels/WorkoutDetailPageViewModel.dart';

class WorkoutDetailPageController extends AutoDisposeAsyncNotifier<WorkoutDetailPageViewModel> {
  WorkoutDetailPageController();
  
  Future<WorkoutDetailPageViewModel> fetch({DifficultyType difficultyType = DifficultyType.beginner}) async {
    final id = ref.read(selectedWorkoutIdProvider);
    final workoutRepository = ref.read(dioWorkoutProvider);
    final queryProvider = ref.read(selectedWorkoutQueryProvider);
    state = const AsyncLoading();
    Map<String, String> querys = {
      "id": id.toString(),
      "difficultyType": difficultyType.index.toString()
    };
    final workout = await AsyncValue.guard(() => workoutRepository.getWorkout(query: queryProvider));
    if (workout is AsyncError) {
      state = AsyncError("Workout could not be fetched", StackTrace.current);
    }
    final comments = await AsyncValue.guard(() => workoutRepository.getWorkoutComments(id));
    if (comments is AsyncError) {
      state = AsyncError("Comments could not be fetched", StackTrace.current);
    }

    var result = WorkoutDetailPageViewModel(
        workout: workout.asData!.value,
        comments: comments.asData!.value);
    state = AsyncValue.data(result);
    return result;
  }

  @override
  FutureOr<WorkoutDetailPageViewModel> build() {
    return fetch();
  }
}