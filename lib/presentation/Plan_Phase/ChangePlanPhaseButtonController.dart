import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dependencyInjection/plansProvider/PlansProvider.dart';
import '../../domain/Models/Plan.dart';
import '../../domain/Models/Workout.dart';

class ChangePlanPhaseButtonController extends AutoDisposeAsyncNotifier<void> {
  // StateNotifier<AsyncValue<void>>
  ChangePlanPhaseButtonController();

  void changePhase(
      {required String id,
      required PhaseType phase,
      required StatusType status,
      required List<String> workoutIds}) async {
    final planRepository = ref.read(planRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => planRepository.updatePlanStatus(
        id: id, phase: phase, status: status, workoutIds: workoutIds));
    /* if (state is AsyncError) {
      state = AsyncError("Plan could not be fetched", StackTrace.current);
    } */
  }

  @override
  FutureOr<void> build() {}
}