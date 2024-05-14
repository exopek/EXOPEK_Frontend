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
      required String workoutId,
      int? rating,
      String? comment
      }) async {
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
    if (comment != null && comment.isNotEmpty || rating != null) {
      state = await AsyncValue.guard(() => workoutRepository.addWorkoutComment(
          workoutId: workoutId, comment: comment ?? '', rating: rating ?? 0));
      if (state is AsyncError) {
        state = AsyncError("Comment Workout failed", StackTrace.current);
      }
    }
  }

  void saveWorkout(String workoutId, {String? comment, int? rating}) async {
    final WorkoutRepository workoutRepository = ref.read(dioWorkoutProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => workoutRepository.completeWorkout(workoutId: workoutId));
    if (state is AsyncError) {
      state = AsyncError("Workout complete could not be saved", StackTrace.current);
    }
    if (comment != null && comment.isNotEmpty || rating != null) {
      state = await AsyncValue.guard(() => workoutRepository.addWorkoutComment(
          workoutId: workoutId, comment: comment ?? '', rating: rating ?? 0));
      if (state is AsyncError) {
        state = AsyncError("Comment Workout failed", StackTrace.current);
      }
    }
  }

  @override
  FutureOr<void> build() {}
}
