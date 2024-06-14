import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/PlanBenefits.dart';
import 'package:exopek_workout_app/components/PlanDetailPage/PhaseDetails.dart';
import 'package:exopek_workout_app/components/Shared/GenericAppBar.dart';
import 'package:exopek_workout_app/components/WorkoutDetailPage/ExerciseInfoCard.dart';
import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:exopek_workout_app/utils/AppUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dependencyInjection/coachProvider/coachPageControllerProvider.dart';
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
          ref.invalidate(asyncPlansPageControllerProvider);
          ref.invalidate(asyncCoachPageControllerProvider);
          AppRouter.goToPlanTransition();
        },
      ),
    );
    final AsyncValue<void> state = ref.watch(planStartProvider);
    var result = ref.watch(asyncPlanDetailPageControllerProvider);
    return result.when(
        data: (result) {
          var distinctWorkouts = result.plan.workouts
              .distinct((a, b) => a.name == b.name)
              .toList();
          return Scaffold(
            appBar: GenericAppBar.build(context, "", hasDivider: false),
            extendBodyBehindAppBar: true,
            body: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 370,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(result.plan
                                  .previewImageUrl /* "https://via.placeholder.com/390x370" */),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 8.0, bottom: 0.0),
                          child: Text(result.plan.name,
                              style: ThemeBase.of(context)
                                  .headlineSmall
                                  .copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: Text(
                              result.plan.description.maybeHandleOverflow(
                                  maxChars: 300, replacement: '...'),
                              style: ThemeBase.of(context).bodySmall.copyWith(
                                    color: ThemeBase.of(context).secondaryText,
                                  ),
                            ),
                          ),
                        ),
                        if (result.planStatus.statusTypeAsType !=
                            StatusType.ACTIVE)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
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
                                }),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                          child: PlanBenefits(
                            benefits: result.plan.uiPlanPromises,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 8, bottom: 16),
                          child: Text(
                            'Workouts',
                            style: ThemeBase.of(context).headlineSmall,
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          width: MediaQuery.sizeOf(context).width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: distinctWorkouts.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16, bottom: 8),
                                child: ExerciseInfoCard(
                                  name: distinctWorkouts[index].name,
                                  sets: "",
                                  duration: "",
                                  imageUrl:
                                      distinctWorkouts[index].previewImageUrl,
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 8, bottom: 0),
                          child: Text(
                            'Programm Details',
                            style: ThemeBase.of(context).headlineSmall,
                          ),
                        ),
                        for (int i = 0; i < result.plan.workoutMap.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                            child: PhaseDetails(
                              title: 'Phase ${i + 1}',
                              workoutPlanConfig: result.plan.workoutMap[
                                      result.sortedCurrentPhaseTypes[i]]
                                  as List<WorkoutPlanConfig>,
                            ),
                          ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator(
              strokeWidth: 0.5,
              color: ThemeBase.of(context).primaryText
        )),
        error: (e, s) => Center(child: Text(e.toString())));
  }
}
