import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/GenericBottomSheet.dart';
import 'package:exopek_workout_app/components/HashTagPill.dart';
import 'package:exopek_workout_app/components/PlanBenefits.dart';
import 'package:exopek_workout_app/components/WorkoutOverviewCard.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/domain/Models/Exercise.dart';
import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/PlanOverviewCard.dart';
import '../../dependencyInjection/plansProvider/PlansProvider.dart';
import '../../domain/Models/Workout.dart';

class PlanDetailPage extends ConsumerStatefulWidget {
  PlanDetailPage({super.key}) {}

  @override
  ConsumerState<PlanDetailPage> createState() => _PlanDetailPageState();
}

class _PlanDetailPageState extends ConsumerState<PlanDetailPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      planStartProvider,
      (_, state) => state.whenOrNull(
        error: (error, stack) {
          // show snackbar if an error occurred
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
        loading: () {},
        data: (_) {
          // rebuild the page to show the new state
          //ref.invalidate(asyncPlanDetailPageControllerProvider);
          AsyncValue<PlanDetailsViewModel> res =
              ref.read(asyncPlanDetailPageControllerProvider);

          res.whenOrNull(
            error: (error, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error.toString())),
              );
            },
            loading: () {},
            data: (result) {
              var planPhase = PlanPhase(
                  planStatus: result.planStatus,
                  workouts:
                      result.plan.workoutMap[result.sortedCurrentPhaseTypes[0]]
                          as List<WorkoutPlanConfig>,
                  plan: result.plan);
              // route to phase page
              AppRouter.goToPlanTransition(planPhase);
            },
          );
        },
      ),
    );
    final AsyncValue<void> state = ref.watch(planStartProvider);
    var result = ref.watch(asyncPlanDetailPageControllerProvider);
    return result.when(
        data: (result) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 1178,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 390,
                            height: 370,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(result.plan
                                    .previewImageUrl /* "https://via.placeholder.com/390x370" */),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 16,
                          top: 50,
                          child: Container(
                            width: 50,
                            height: 50,
                            child: IconButton(
                                onPressed: () => GenericBottomSheet.showOptions(
                                        context: context,
                                        items: [
                                          {
                                            'icon': Icons.share,
                                            'title': 'Teilen',
                                            'onTap': () {}
                                          }
                                        ]),
                                icon: Icon(Icons.menu)),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          top: 385,
                          child: Text(
                            result.plan.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          top: 837,
                          child: Text(
                            'Phasen des Programms',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        /* Positioned(
                          left: 16,
                          top: 862,
                          child: Text(
                            'Aktuelle Phase: ${result.planStatus.currentPhase}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ), */
                        if (result.planStatus.statusTypeAsType !=
                            StatusType.ACTIVE)
                          Positioned(
                              left: 16,
                              right: 16,
                              top: 582,
                              child: CtaButton(
                                  isLoading: state.isLoading,
                                  label: result.planStatus.statusTypeAsType !=
                                          StatusType.ACTIVE
                                      ? 'Starten'
                                      : 'Active Plan',
                                  onPressed: () {
                                    if (result.planStatus.statusTypeAsType ==
                                        StatusType.ACTIVE) return;
                                    if (state.isLoading) return;
                                    ref
                                        .read(planStartProvider.notifier)
                                        .startPlan();
                                  })),
                        Positioned(
                          left: 16,
                          top: 429,
                          child: SizedBox(
                            width: 350,
                            child: Text(
                              result.plan.description,
                              style: TextStyle(
                                color: Color(0xFF838282),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            left: 0,
                            top: 867,
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              height: 130,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(left: 16),
                                  itemCount: result.plan.workoutMap.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: PlanOverviewCard(
                                        statusType: result.planStatus!
                                            .statusTypeAsType as StatusType,
                                        round: index,
                                        planPhase: PlanPhase(
                                            planStatus: result.planStatus,
                                            workouts: result.plan.workoutMap[
                                                result.sortedCurrentPhaseTypes[
                                                    index]] as List<
                                                WorkoutPlanConfig>,
                                            plan: result.plan),
                                        currentPhaseType:
                                            result.planStatus!.currentPhase,
                                        phaseType: result
                                                .sortedCurrentPhaseTypes[index]
                                            as int,
                                      ),
                                    );
                                  }),
                            )),
                        Positioned(left: 16, top: 666, child: PlanBenefits()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(e.toString())));
  }
}
