import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/PlanRepository.dart';
import '../../domain/Models/Plan.dart';
import '../../presentation/Plan/PlanDetailPageController.dart';
import '../../presentation/Plan/StartPlanButtonStateController.dart';
import '../../presentation/Plan_Phase/StopPlanButtonStateController.dart';

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
  final data = await ref.watch(planRepositoryProvider).getPlanStatuses(id);
  return data as List<PlanStatus>;
});

final planDetailProvider =
    FutureProvider.autoDispose<PlanDetailsViewModel>((ref) async {
  final id = ref.read(selectedPlanIdProvider);
  final data1 = await ref.watch(planRepositoryProvider).getPlan(id);
  final data2 = await ref.watch(planRepositoryProvider).getPlanStatuses(id);
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

final planPhaseStopButtonProvider =
    AsyncNotifierProvider.autoDispose<StopPlanButtonStateController, void>(() {
  return StopPlanButtonStateController();
});

final selectedPlanIdProvider = StateProvider<String>((ref) => '');
