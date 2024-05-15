import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/AppStateProvider.dart';
import '../../data/DioProvider.dart';
import '../../domain/Models/ViewModels/WorkoutDetailPageViewModel.dart';

class WorkoutDetailPageController extends AutoDisposeAsyncNotifier<WorkoutDetailPageViewModel> {
  WorkoutDetailPageController();
  
  Future<WorkoutDetailPageViewModel> fetch() async {
    final id = ref.read(selectedWorkoutIdProvider);
    final workoutRepository = ref.read(dioWorkoutProvider);
    state = const AsyncLoading();
    final workout = await AsyncValue.guard(() => workoutRepository.getWorkout(id));
    if (workout is AsyncError) {
      state = AsyncError("Workout could not be fetched", StackTrace.current);
    }
    final comments = await AsyncValue.guard(() => workoutRepository.getWorkoutComments(id));
    if (comments is AsyncError) {
      state = AsyncError("Comments could not be fetched", StackTrace.current);
    }

    return WorkoutDetailPageViewModel(
        workout: workout.asData!.value,
        comments: comments.asData!.value);
  }

  @override
  FutureOr<WorkoutDetailPageViewModel> build() {
    return fetch();
  }
}