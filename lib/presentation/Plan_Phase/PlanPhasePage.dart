import 'package:exopek_workout_app/components/WorkoutCard.dart';
import 'package:exopek_workout_app/components/WorkoutLists/WorkoutCardHorizontal.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/WorkoutDetailPageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/GenericBottomSheet.dart';
import '../../data/AppStateProvider.dart';
import '../../dependencyInjection/coachProvider/coachPageControllerProvider.dart';
import '../../dependencyInjection/plansProvider/PlansProvider.dart';
import '../../domain/Models/Plan.dart';
import '../../domain/Models/Workout.dart';
import '../../utils/AppRouter.dart';

class PlanPhasePage extends ConsumerStatefulWidget {
  const PlanPhasePage({super.key});

  @override
  ConsumerState<PlanPhasePage> createState() => _PlanPhasePageState();
}

class _PlanPhasePageState extends ConsumerState<PlanPhasePage> {
  /*  WorkoutPlanConfig get currentWorkoutPlanConfig =>
      widget.workoutPlanConfig![0]; */

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      planPhaseStopButtonProvider,
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
          ref.invalidate(asyncPlansPageControllerProvider);
          ref.invalidate(asyncCoachPageController);
          Navigator.of(context).pop();
        },
      ),
    );
    ref.listen<AsyncValue<void>>(
      planPhaseChangeButtonProvider,
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
          ref.invalidate(asyncPlanPhasePageControllerProvider);
        },
      ),
    );
    final state = ref.watch(planPhaseStopButtonProvider);
    final planPhase = ref.watch(asyncPlanPhasePageControllerProvider);
    return planPhase.when(
      data: (data) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF0C0C0C),
              title: Text(data.plan.name),
              actions: [
                IconButton(
                    onPressed: () => GenericBottomSheet.showOptions(
                            context: context,
                            items: [
                              {
                                'icon': Icons.stop_circle_outlined,
                                'title': 'Plan Stoppen',
                                'onTap': () => ref
                                    .read(planPhaseStopButtonProvider.notifier)
                                    .stopPlan(data.planStatus!.id)
                              },
                              {
                                'icon': Icons.change_circle_outlined,
                                'title': 'Phase Abschließen',
                                'onTap': () => ref.read(planPhaseChangeButtonProvider.notifier).changePhase(
                                    id: data.planStatus!.id,
                                    phase: data
                                                .plan
                                                .sortedCurrentPhaseTypesAsType
                                                .length >
                                            data.planStatus!.phaseTypeAsType.index +
                                                1
                                        ? data.plan.sortedCurrentPhaseTypesAsType[
                                            data.planStatus!.phaseTypeAsType.index +
                                                1]
                                        : data.plan.sortedCurrentPhaseTypesAsType[
                                            data.planStatus!.phaseTypeAsType.index],
                                    workoutIds: data.planStatus!.workoutIds,
                                    status: data.planStatus!.statusTypeAsType)
                              },
                            ]),
                    icon: Icon(Icons.menu)),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 844,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
                child: Stack(
                  children: [
                    Positioned(
                      left: 16,
                      top: 44,
                      child: Text(
                        data.planStatus!.phaseTypeAsString,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 103,
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width - 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (var i = 0; i < data.workouts.length; i++)
                              Expanded(
                                child: Container(
                                  height: 7,
                                  decoration: ShapeDecoration(
                                    color: (i <
                                            int.parse(data
                                                .completedWorkoutsCounter
                                                .toString()))
                                        ? Color(0xFFCE2323)
                                        : Color(0xFF262424),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 118,
                      child: Text(
                        'Abgeschlossene Workouts: ${data.completedWorkoutsCounter} von ${data.workouts.length}',
                        style: TextStyle(
                          color: Color(0xFF838282),
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 165,
                      child: Container(
                        width: 358,
                        height: 291,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(data
                                .previewImageUrl), // "https://via.placeholder.com/358x291"
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 476,
                      left: 16,
                      child: Column(
                        children: [
                          for (var index = 0;
                              index < data.workouts.length;
                              index++)
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(selectedWorkoutIdProvider.notifier)
                                    .state = data.workouts[index].id;
                                AppRouter.goToWorkoutDetail(
                                  viewModel: WorkoutDetailPageViewModel(
                                      planStatus: data.planStatus,
                                      planWorkoutId:
                                          data.workouts[index].planWorkoutId)
                                );
                              },
                              child: WorkoutCardHorizontal(
                                hasTrained: data.planStatus!.workoutIds
                                    .contains(
                                        data.workouts[index].planWorkoutId),
                                workout: WorkoutListItem(
                                    id: data.workouts[index].id,
                                    name: data.workouts[index].name,
                                    previewImageUrl:
                                        data.workouts[index].previewImageUrl,
                                    hashtags: "hashtags",
                                    duration: 20,
                                    isWorkoutOfTheWeek: false),
                              ),
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text(error.toString())),
    );
  }
}
