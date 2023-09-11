import 'package:exopek_workout_app/presentation/LoopVideos/LoopVideosAnimationController.dart';
import 'package:exopek_workout_app/presentation/LoopVideos/LoopVideosController.dart';
import 'package:exopek_workout_app/presentation/LoopVideos/LoopVideosProgressIndicatorController.dart';
import 'package:exopek_workout_app/presentation/LoopVideos/TimerAnimationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final abortValueProvider = StateProvider<int>((ref) => 30);

final selectedExerciseProvider = StateProvider<int>((ref) => 0);

//final vsyncProvider = Provider<TickerProvider>((ref) => ref.read(vsyncProvider));

final timerAnimationControllerProvider =
    StateNotifierProvider<TimerAnimationLController, int>((ref) {
  final abortValue = ref.watch(abortValueProvider);
  return TimerAnimationLController();
});

final loopVideosControllerProvider =
    StateNotifierProvider<LoopVideosController, int>((ref) {
  //final selectedExercise = ref.watch(selectedExerciseProvider);
  return LoopVideosController();
});

final loopVideosProgressIndicatorControllerProvider =
    StateNotifierProvider<LoopVideosProgressIndicatorController, int>((ref) {
  //final selectedExercise = ref.watch(selectedExerciseProvider);
  return LoopVideosProgressIndicatorController();
});

/* final loopVideosAnimationCControllerProvider =
    StateNotifierProvider<LoopVideosAnimationController, AnimationController>((ref) {
  final abortValue = ref.watch(abortValueProvider);
  return LoopVideosAnimationController(
    abortValue, 
  );
}); */
