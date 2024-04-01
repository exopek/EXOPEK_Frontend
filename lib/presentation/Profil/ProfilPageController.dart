import 'dart:async';

import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/ProfilPageViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilPageController extends AutoDisposeAsyncNotifier<ProfilPageViewModel> {
  ProfilPageController();

  Future<ProfilPageViewModel> fetch() async {
    final workoutRepository = ref.read(dioWorkoutProvider);
    final userRepository = ref.read(userRepositoryProvider);
    state = const AsyncLoading();
    final workoutResult = await AsyncValue.guard(
        () => workoutRepository.getWorkoutCompletes());
    if (workoutResult is AsyncError) {
      state = AsyncError("Workouts could not be fetched", StackTrace.current);
    }
    final user = await AsyncValue.guard(() => userRepository.getUser());
    if (user is AsyncError) {
      state = AsyncError("User could not be fetched", StackTrace.current);
    }
    
    return ProfilPageViewModel(
        workouts: workoutResult.asData!.value,
        user: user.asData!.value);
  }

  @override
  FutureOr<ProfilPageViewModel> build() {
    return fetch();
  }
}