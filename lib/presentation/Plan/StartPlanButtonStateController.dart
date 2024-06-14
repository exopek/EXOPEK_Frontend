import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dependencyInjection/plansProvider/PlansProvider.dart';

class StartPlanButtonStateController extends AutoDisposeAsyncNotifier<void> {
  // StateNotifier<AsyncValue<void>>
  StartPlanButtonStateController();

  void startPlan() async {
    final id = ref.read(selectedPlanIdProvider);
    final planRepository = ref.read(planRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => planRepository.startPlan(id, ""));
  }

  void stopPlan(String id) async {
    final planRepository = ref.read(planRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => planRepository.stopPlan(id));
  }

  @override
  FutureOr<void> build() {}
}
