// ignore_for_file: file_names
import 'package:exopek_workout_app/components/PlanCardHorizontal.dart';
import 'package:exopek_workout_app/components/Shared/GenericAppBar.dart';
import 'package:exopek_workout_app/dependencyInjection/plansProvider/PlansProvider.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            appBar: GenericAppBar.build(context, AppLocalizations.of(context).plansPageTitle),
            body: CustomScrollView(slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextButton(
                          onPressed: () {
                            if (result.planStatuses.any((element) =>
                                element.planId == result.plans[index].id)) {
                              ref.read(selectedPlanIdProvider.notifier).state =
                                  result.plans[index].id;
                              AppRouter.goToPlanPhaseWithLastRoute();
                            } else {
                              ref.read(selectedPlanIdProvider.notifier).state =
                                  result.plans[index].id;
                              AppRouter.goToPlanDetail();
                            }
                          },
                          child: PlanCardHorizontal(
                                          planListItem: result.plans[index],
                          )
                        ),
                      );
                    },
                    childCount: result.plans.length,
                  ),
                ),
              ]),
            
          );
        },
        loading: () => Center(child: CircularProgressIndicator(
          strokeWidth: 0.5,
          color: ThemeBase.of(context).primaryText,
        )),
        error: (e, s) => Container());
  }
}
