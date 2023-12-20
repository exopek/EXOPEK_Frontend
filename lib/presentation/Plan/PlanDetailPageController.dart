import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dependencyInjection/plansProvider/PlansProvider.dart';
import '../../domain/Models/Plan.dart';

class PlanDetailPageController
    extends AutoDisposeAsyncNotifier<PlanDetailsViewModel> {
  PlanDetailPageController();

  @override
  Future<PlanDetailsViewModel> build() async {
    return await fetchPlanAndStatus();
  }

  // fetch

  Future<PlanDetailsViewModel> fetchPlanAndStatus() async {
    final id = ref.read(selectedPlanIdProvider);
    final data1 = await ref.watch(planRepositoryProvider).getPlan(id);
    final data2 = await ref.watch(planRepositoryProvider).getPlanStatuses(id);
    return PlanDetailsViewModel(
        plan: data1,
        planStatus: data2.isNotEmpty ? data2.first : PlanStatus.empty());
  }

  void startPlan() async {
    final id = ref.read(selectedPlanIdProvider);
    final planRepository = ref.read(planRepositoryProvider);
    state = const AsyncLoading();
    var res = await AsyncValue.guard(() => planRepository.startPlan(id, ""));
    if (res is AsyncError) {
      state = AsyncError("Plan could not be started", StackTrace.current);
    }
    state = await AsyncValue.guard(() => fetchPlanAndStatus());
  }
}
