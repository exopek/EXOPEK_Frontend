import 'package:exopek_workout_app/components/PlanListCard.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dependencyInjection/plansProvider/PlansProvider.dart';
import '../../utils/AppRouter.dart';

class PlansPage extends ConsumerStatefulWidget {
  const PlansPage({super.key});

  @override
  ConsumerState<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends ConsumerState<PlansPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(asyncPlansPageControllerProvider);
    return result.when(
      data: (result) {
        return Scaffold(
          backgroundColor: ThemeBase.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: ThemeBase.of(context).secondaryBackground,
            centerTitle: false,
            title: const Text('Pläne'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: result.plans.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (result.planStatuses.any((element) =>
                                element.planId == result.plans[index].id)) {
                              print("active plan");
                              ref.read(selectedPlanIdProvider.notifier).state =
                                  result.plans[index].id;
                              AppRouter.goToPlanPhaseWithLastRoute();
                            } else {
                              ref.read(selectedPlanIdProvider.notifier).state =
                                  result.plans[index].id;
                              AppRouter.goToPlanDetail();
                            }
                          },
                          child: PlanListCard(
                            planListItem: result.plans[index],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
    );
  }
}
