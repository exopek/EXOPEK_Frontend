import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/PlanRepository.dart';
import '../../domain/Models/Plan.dart';
import '../../domain/Models/ViewModels/PlansPageViewModel.dart';
import '../../presentation/Plan/PlanDetailPageController.dart';
import '../../presentation/Plan/StartPlanButtonStateController.dart';
import '../../presentation/Plan_Phase/ChangePlanPhaseButtonController.dart';
import '../../presentation/Plan_Phase/PlanPhasePageController.dart';
import '../../presentation/Plan_Phase/StopPlanButtonStateController.dart';
import '../../presentation/Plans/PlansPageController.dart';
import '../../presentation/WorkoutSummary/WorkoutSummarySaveButtonController.dart';

final planRepositoryProvider = Provider<PlanRepository>((ref) {
  return PlanRepository(ref);
});

final plansProvider =
    FutureProvider.autoDispose<List<PlanListItem>>((ref) async {
  final data = await ref.watch(planRepositoryProvider).getPlans();
  return data;
});

final planStatusesProvider =
    FutureProvider.autoDispose<List<PlanStatus>>((ref) async {
  final id = ref.read(selectedPlanIdProvider);
  final data =
      await ref.watch(planRepositoryProvider).getPlanStatuses(planId: id);
  return data as List<PlanStatus>;
});

final planStartProvider =
    AsyncNotifierProvider.autoDispose<StartPlanButtonStateController, void>(() {
  return StartPlanButtonStateController();
});

final asyncPlanDetailPageControllerProvider = AsyncNotifierProvider.autoDispose<
    PlanDetailPageController, PlanDetailsViewModel>(() {
  return PlanDetailPageController();
});

final asyncPlansPageControllerProvider =
    AsyncNotifierProvider.autoDispose<PlansPageController, PlansPageViewModel>(
        () => PlansPageController());
  
final asyncPlanPhasePageControllerProvider = AsyncNotifierProvider.autoDispose<
    PlanPhasePageController, PlanPhaseViewModel>(() {
  return PlanPhasePageController();
});

final planPhaseStopButtonProvider =
    AsyncNotifierProvider.autoDispose<StopPlanButtonStateController, void>(() {
  return StopPlanButtonStateController();
});

final planPhaseChangeButtonProvider =
    AsyncNotifierProvider.autoDispose<ChangePlanPhaseButtonController, void>(
        () {
  return ChangePlanPhaseButtonController();
});

final asyncWorkoutSummarySaveButtonControllerProvider =
    AsyncNotifierProvider.autoDispose<WorkoutSummarySaveButtonController, void>(
        () {
  return WorkoutSummarySaveButtonController();
});

final selectedPlanIdProvider = StateProvider<String>((ref) => '');

final selectedPlanQueryProvider = StateProvider<Map<String, String>>((ref) => {});
