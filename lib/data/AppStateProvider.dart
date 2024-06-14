import 'package:exopek_workout_app/domain/Models/Like.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedNavigationBarIndexProvider = StateProvider<int>((ref) => 0);

final selectedWorkoutIdProvider = StateProvider<String>((ref) => '');

final currentRouteProvider = Provider<String>((ref) {
  final index = ref.watch(selectedNavigationBarIndexProvider);
  switch (index) {
    case 0:
      return "/home";
    case 1:
      return "/search";
    case 2:
      return "/profile";
    default:
      return "/home";
  }
});

final likedWorkoutIdsProvider = StateProvider<List<LikeReadDto>>((ref) => []);

final menuBarWidthProvider = StateProvider<double>((ref) => 0.0);

final localizationProvider = StateProvider<String>((ref) => 'en-US');
