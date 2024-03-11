import 'dart:async';

import 'package:exopek_workout_app/domain/Models/ViewModels/DiscoverFilterPageViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/DioProvider.dart';
import '../../dependencyInjection/discoveryProvider/discoveryFilterPageProvider.dart';
import '../../dependencyInjection/plansProvider/PlansProvider.dart';
import '../../domain/Models/Plan.dart';

enum FetchType { none, plan, workout, challenge }

class DiscoverFilterPageController
    extends AutoDisposeAsyncNotifier<DiscoverFilterPageViewModel> {
  DiscoverFilterPageController();

  Future<DiscoverFilterPageViewModel> fetch() async {
    final fetchType = ref.watch(fetchStateProvider);
    final query = ref.watch(queryProvider);
    if (fetchType == FetchType.none) {
      return DiscoverFilterPageViewModel(
          plans: List.empty(), workouts: List.empty());
    }
    if (fetchType == FetchType.plan) {
      final planRepository = ref.read(planRepositoryProvider);
      state = const AsyncLoading();
      final result =
          await AsyncValue.guard(() => planRepository.getPlans(query: query));
      if (result is AsyncError) {
        state = AsyncError("Plans could not be fetched", StackTrace.current);
      }
      return DiscoverFilterPageViewModel(
          plans: result.asData!.value, workouts: List.empty());
    }
    if (fetchType == FetchType.workout) {
      final workoutRepository = ref.read(dioWorkoutProvider);
      state = const AsyncLoading();
      final result = await AsyncValue.guard(
          () => workoutRepository.getWorkouts(query: query));
      if (result is AsyncError) {
        state = AsyncError("Workouts could not be fetched", StackTrace.current);
      }
      return DiscoverFilterPageViewModel(
          plans: List.empty(), workouts: result.asData!.value);
    }
    return DiscoverFilterPageViewModel(
        plans: List.empty(), workouts: List.empty());
  }

  @override
  FutureOr<DiscoverFilterPageViewModel> build() {
    return fetch();
  }
}
