import 'dart:async';

import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/data/repository/UserRepository.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/DiscoverFilterPageViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/DioProvider.dart';
import '../../dependencyInjection/discoveryProvider/discoveryFilterPageProvider.dart';
import '../../dependencyInjection/plansProvider/PlansProvider.dart';
import '../../domain/Models/ViewModels/CoachPageViewModel.dart';
import '../../domain/Models/Plan.dart';

class CoachPageController extends AutoDisposeAsyncNotifier<CoachPageViewModel> {
  CoachPageController();

  Future<CoachPageViewModel> fetch() async {
    final planRepository = ref.read(planRepositoryProvider);
    final workoutRepository = ref.read(dioWorkoutProvider);
    final userRepository = ref.read(userRepositoryProvider);
    state = const AsyncLoading();
    final planResult =
        await AsyncValue.guard(() => planRepository.getPlans(query: "All"));
    if (planResult is AsyncError) {
      state = AsyncError("Plans could not be fetched", StackTrace.current);
    }
    final workoutResult = await AsyncValue.guard(
        () => workoutRepository.getWorkouts(query: "All"));
    if (workoutResult is AsyncError) {
      state = AsyncError("Workouts could not be fetched", StackTrace.current);
    }
    final user = await AsyncValue.guard(() => userRepository.getUser());
    if (user is AsyncError) {
      state = AsyncError("User could not be fetched", StackTrace.current);
    }
    final planStatusResult = await AsyncValue.guard(
        () => planRepository.getPlanStatuses(status: StatusType.ACTIVE));
    if (planStatusResult is AsyncError) {
      state =
          AsyncError("PlanStatuses could not be fetched", StackTrace.current);
    }

    final planIds =
        planStatusResult.asData!.value.map((e) => e.planId).toSet().toList();
    if (planIds.isEmpty) {
      ref.read(userStateProvider.notifier).state = user.asData!.value;
      return CoachPageViewModel(
          plans: planResult.asData!.value,
          workouts: workoutResult.asData!.value,
          startedPlans: [],
          planStatuses: [],
          user: user.asData!.value);
    }
    final startedPlans = await AsyncValue.guard(
        () => planRepository.getPlans(planIds: planIds.join(",")));
    if (startedPlans is AsyncError) {
      state =
          AsyncError("StartedPlans could not be fetched", StackTrace.current);
    }
    final likedWorkoutsResult = await AsyncValue.guard(
        () => workoutRepository.getWorkoutLikes());
    if (likedWorkoutsResult is AsyncError) {
      state = AsyncError("LikedWorkoutId could not be fetched", StackTrace.current);
    }
    ref.read(likedWorkoutIdsProvider.notifier).state = likedWorkoutsResult.asData!.value.map((e) => e).toList();
    
    ref.read(userStateProvider.notifier).state = user.asData!.value;
    return CoachPageViewModel(
        plans: planResult.asData!.value,
        workouts: workoutResult.asData!.value,
        startedPlans: startedPlans.asData!.value,
        planStatuses: planStatusResult.asData!.value,
        user: user.asData!.value);
  }

  @override
  FutureOr<CoachPageViewModel> build() {
    return fetch();
  }
}
