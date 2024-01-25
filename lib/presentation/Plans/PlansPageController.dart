import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dependencyInjection/plansProvider/PlansProvider.dart';
import '../../domain/Models/Plan.dart';
import '../../domain/Models/PlansPageViewModel.dart';

class PlansPageController extends AutoDisposeAsyncNotifier<PlansPageViewModel> {
  PlansPageController();

  @override
  Future<PlansPageViewModel> build() async {
    return await fetchPlansAndStatus();
  }

  // fetch

  Future<PlansPageViewModel> fetchPlansAndStatus() async {
    final planRepository = ref.read(planRepositoryProvider);
    state = const AsyncLoading();
    final planResult = await AsyncValue.guard(() => planRepository.getPlans());
    if (planResult is AsyncError) {
      state = AsyncError("Plans could not be fetched", StackTrace.current);
    }
    final activePlanStatuses = await AsyncValue.guard(
        () => planRepository.getPlanStatuses(status: StatusType.ACTIVE));
    if (activePlanStatuses is AsyncError) {
      state =
          AsyncError("PlanStatuses could not be fetched", StackTrace.current);
    }
    return PlansPageViewModel(
        plans: planResult.asData!.value,
        planStatuses: activePlanStatuses.asData!.value);
  }
}
