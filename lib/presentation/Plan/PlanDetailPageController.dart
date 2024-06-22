import 'package:exopek_workout_app/domain/Models/Enums/DifficultyType.dart';
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

  Future<PlanDetailsViewModel> fetchPlanAndStatus({DifficultyType difficultyType = DifficultyType.beginner}) async {
    final id = ref.read(selectedPlanIdProvider);
    Map<String, String> querys = {
      "difficultyType": difficultyType.index.toString()
    };
    state = const AsyncLoading();
    final data1 = await ref.watch(planRepositoryProvider).getPlan(id, query: querys);
    if (data1 is AsyncError) {
      state = AsyncError("Plan could not be fetched", StackTrace.current);
    }
    final data2 =
        await ref.watch(planRepositoryProvider).getPlanStatuses(planId: id);
    if (data2 is AsyncError) {
      state = AsyncError("PlanStatuses could not be fetched", StackTrace.current);
    }
    var result = PlanDetailsViewModel(
        plan: data1,
        planStatus: data2.isNotEmpty ? data2.first : PlanStatus.empty());
    state = AsyncValue.data(result);
    return PlanDetailsViewModel(
        plan: data1,
        planStatus: data2.isNotEmpty ? data2.first : PlanStatus.empty());
  }

  void startPlan({DifficultyType difficultyType = DifficultyType.beginner}) async {
    final id = ref.read(selectedPlanIdProvider);
    final planRepository = ref.read(planRepositoryProvider);
    state = const AsyncLoading();
    var res = await AsyncValue.guard(() => planRepository.startPlan(id, difficultyType));
    if (res is AsyncError) {
      state = AsyncError("Plan could not be started", StackTrace.current);
    }
    state = await AsyncValue.guard(() => fetchPlanAndStatus());
  }
}
