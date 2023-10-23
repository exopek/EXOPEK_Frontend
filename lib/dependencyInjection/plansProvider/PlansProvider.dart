import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/PlanRepository.dart';
import '../../domain/Models/Plan.dart';

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

final selectedPlanIdProvider = StateProvider<String>((ref) => '');
