import 'package:exopek_workout_app/domain/Models/Enums/DifficultyType.dart';
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
    print(id);
    state = const AsyncLoading();
    // Erst Status holen, um die Schwierigkeit zu bestimmen
    final planStatus = await AsyncValue.guard(
        () => ref.watch(planRepositoryProvider).getPlanStatuses(planId: id));
    if (planStatus is AsyncError) {
      state =
          AsyncError("PlanStatuses could not be fetched", StackTrace.current);
          print("Error planStatus");
      print(planStatus.error);
          print(StackTrace.current);
    }
    Map<String, String> querys = {
      "difficultyType": planStatus.asData!.value.isNotEmpty
          ? planStatus.asData!.value.first.difficultyType!.index.toString()
          : DifficultyType.beginner.index.toString()
    };
    final resultPlan = await AsyncValue.guard(
        () => ref.watch(planRepositoryProvider).getPlan(id, query: querys));
    if (resultPlan is AsyncError) {
      print("Error resultPlan");
      print(resultPlan.error);
      print(StackTrace.current);
      state = AsyncError("Plan could not be fetched", StackTrace.current);
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
