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
