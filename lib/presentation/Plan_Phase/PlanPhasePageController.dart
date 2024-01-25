import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dependencyInjection/plansProvider/PlansProvider.dart';
import '../../domain/Models/Plan.dart';
import '../../domain/Models/Workout.dart';

class PlanPhasePageController
    extends AutoDisposeAsyncNotifier<PlanPhaseViewModel> {
  PlanPhasePageController();

  @override
  Future<PlanPhaseViewModel> build() async {
    return await fetchPlanAndStatus();
  }

  Future<PlanPhaseViewModel> fetchPlanAndStatus() async {
    final id = ref.read(selectedPlanIdProvider);
    state = const AsyncLoading();
    final resultPlan = await AsyncValue.guard(
        () => ref.watch(planRepositoryProvider).getPlan(id));
    if (resultPlan is AsyncError) {
      state = AsyncError("Plan could not be fetched", StackTrace.current);
    }
    final planStatus = await AsyncValue.guard(
        () => ref.watch(planRepositoryProvider).getPlanStatuses(planId: id));
    if (planStatus is AsyncError) {
      state =
          AsyncError("PlanStatuses could not be fetched", StackTrace.current);
    }
    var workouts = resultPlan.asData!.value
            .workoutMap[planStatus.asData!.value.first.currentPhase]
        as List<WorkoutPlanConfig>;
    return PlanPhaseViewModel(
        plan: resultPlan.asData!.value,
        planStatus: planStatus.asData!.value.isNotEmpty
            ? planStatus.asData!.value.first
            : PlanStatus.empty(),
        workouts: workouts);
  }
}
