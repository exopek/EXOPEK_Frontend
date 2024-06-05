import 'dart:async';

import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/workoutProvider/WorkoutProvider.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/WorkoutsViewModel.dart';
import 'package:exopek_workout_app/domain/Models/workout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutsPageController extends AutoDisposeAsyncNotifier<WorkoutsViewModel> {
  WorkoutsPageController();

  @override
  FutureOr<WorkoutsViewModel> build() async {
    return fetchWorkouts();
  }

  Future<WorkoutsViewModel> fetchWorkouts() async {
    final workoutRepository = ref.read(dioWorkoutProvider);
    final queryProvider = ref.read(selectedWorkoutQueryProvider);
    state = const AsyncLoading();
    final workoutResult = await AsyncValue.guard(() => workoutRepository.getWorkouts(query: queryProvider));
    if (workoutResult is AsyncError) {
      state = AsyncError("Workouts could not be fetched", StackTrace.current);
    }
    
    return WorkoutsViewModel(workouts: workoutResult.asData!.value);
  }
}
