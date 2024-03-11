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

final planSingleProvider = FutureProvider.autoDispose<PlanDetails>((ref) async {
  final id = ref.read(selectedPlanIdProvider);
  final data = await ref.watch(planRepositoryProvider).getPlan(id);
  return data;
});

final planStatusesProvider =
    FutureProvider.autoDispose<List<PlanStatus>>((ref) async {
  final id = ref.read(selectedPlanIdProvider);
  final data =
      await ref.watch(planRepositoryProvider).getPlanStatuses(planId: id);
  return data as List<PlanStatus>;
});

final planDetailProvider =
    FutureProvider.autoDispose<PlanDetailsViewModel>((ref) async {
  final id = ref.read(selectedPlanIdProvider);
  final data1 = await ref.watch(planRepositoryProvider).getPlan(id);
  final data2 =
      await ref.watch(planRepositoryProvider).getPlanStatuses(planId: id);
  return PlanDetailsViewModel(
      plan: data1,
      planStatus: data2.isNotEmpty ? data2.first : PlanStatus.empty());
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
        () {
  return PlansPageController();
});

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
