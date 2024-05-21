import 'dart:async';

import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/plansProvider/PlansProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/ProfilPageViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilPageController extends AutoDisposeAsyncNotifier<ProfilPageViewModel> {
  ProfilPageController();

  Future<ProfilPageViewModel> fetch() async {
    final workoutRepository = ref.read(dioWorkoutProvider);
    final userRepository = ref.read(userRepositoryProvider);
    final planRepository = ref.read(planRepositoryProvider);
    state = const AsyncLoading();
    final workoutResult = await AsyncValue.guard(
        () => workoutRepository.getWorkoutCompletes());
    if (workoutResult is AsyncError) {
      state = AsyncError("Workouts could not be fetched", StackTrace.current);
    }
    final planStatusResult = await AsyncValue.guard(
        () => planRepository.getPlanStatuses(status: StatusType.COMPLETED)); 
    if (planStatusResult is AsyncError) {
      state = AsyncError("Plan statuses could not be fetched", StackTrace.current);
    }
    final planResult = await AsyncValue.guard(
        () => planRepository.getPlans(planIds: planStatusResult.asData!.value.map((e) => e.planId).join(",")));
    if (planResult is AsyncError) {
      state = AsyncError("Plans could not be fetched", StackTrace.current);
    }
    final user = await AsyncValue.guard(() => userRepository.getUser());
    if (user is AsyncError) {
      state = AsyncError("User could not be fetched", StackTrace.current);
    }
    
    return ProfilPageViewModel(
        workouts: workoutResult.asData!.value,
        user: user.asData!.value,
        plans: planResult.asData!.value,
        planStatuses: planStatusResult.asData!.value);
  }

  @override
  FutureOr<ProfilPageViewModel> build() {
    return fetch();
  }
}