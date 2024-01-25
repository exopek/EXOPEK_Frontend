import 'dart:async';

import 'package:exopek_workout_app/data/repository/WorkoutRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/DioProvider.dart';
import '../../dependencyInjection/plansProvider/PlansProvider.dart';
import '../../domain/Models/Plan.dart';
import '../../domain/Models/Workout.dart';

class WorkoutSummarySaveButtonController
    extends AutoDisposeAsyncNotifier<void> {
  // StateNotifier<AsyncValue<void>>
  WorkoutSummarySaveButtonController();

  void saveWorkoutAndUpdatePlanStatus(
      {required String id,
      required StatusType status,
      required PhaseType phase,
      required List<String> workoutIds,
      required String workoutId}) async {
    final planRepository = ref.read(planRepositoryProvider);
    final WorkoutRepository workoutRepository = ref.read(dioWorkoutProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => planRepository.updatePlanStatus(
        id: id, status: status, phase: phase, workoutIds: workoutIds));
    if (state is AsyncError) {
      state = AsyncError("Plan could not be stopped", StackTrace.current);
    }
    state = await AsyncValue.guard(
        () => workoutRepository.completeWorkout(workoutId: workoutId));
    if (state is AsyncError) {
      state = AsyncError("Plan could not be fetched", StackTrace.current);
    }
  }

  void saveWorkout(String workoutId) async {
    final WorkoutRepository workoutRepository = ref.read(dioWorkoutProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => workoutRepository.completeWorkout(workoutId: workoutId));
    if (state is AsyncError) {
      state = AsyncError("Plan could not be fetched", StackTrace.current);
    }
  }

  @override
  FutureOr<void> build() {}
}
