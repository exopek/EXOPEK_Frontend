import 'dart:async';

import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/domain/Models/Like.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutLikeButtonController
    extends AutoDisposeAsyncNotifier<void> {
  WorkoutLikeButtonController();

  Future<LikeReadDto> likeWorkout({required String workoutId}) async {
    
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
        () => ref.watch(dioWorkoutProvider).likeWorkout(workoutId: workoutId));
    if (result is AsyncError) {
      state = AsyncError("Plan could not be fetched", StackTrace.current);
    }
    
    return result.asData!.value;
  }

  Future<bool> deleteWorkoutLike({required String workoutLikeId}) async {
    
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
        () => ref.watch(dioWorkoutProvider).deleteWorkoutLike(workoutLikeId: workoutLikeId));
    if (result is AsyncError) {
      state = AsyncError("Plan could not be fetched", StackTrace.current);
    }
    
    return true;
  }

  @override
  FutureOr<void> build() {
    
  }
}