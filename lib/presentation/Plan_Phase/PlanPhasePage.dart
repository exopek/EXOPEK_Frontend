import 'package:exopek_workout_app/components/GenericSnackBar.dart';
import 'package:exopek_workout_app/components/Shared/GenericAppBar.dart';
import 'package:exopek_workout_app/components/WorkoutLists/WorkoutCardHorizontal.dart';
import 'package:exopek_workout_app/dependencyInjection/workoutProvider/WorkoutProvider.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/GenericBottomSheet.dart';
import '../../data/AppStateProvider.dart';
import '../../dependencyInjection/coachProvider/coachPageControllerProvider.dart';
import '../../dependencyInjection/plansProvider/PlansProvider.dart';
import '../../domain/Models/Workout.dart';
import '../../utils/AppRouter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlanPhasePage extends ConsumerStatefulWidget {
  const PlanPhasePage({super.key});

  @override
  ConsumerState<PlanPhasePage> createState() => _PlanPhasePageState();
}

class _PlanPhasePageState extends ConsumerState<PlanPhasePage> {
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      planPhaseStopButtonProvider,
      (_, state) => state.whenOrNull(
        error: (error, stack) {
          // show snackbar if an error occurred
          GenericSnackBar.showErrorSnackBar(
              context: context, text: error.toString());
        },
        loading: () {},
        data: (_) {
          ref.invalidate(asyncPlansPageControllerProvider);
          ref.invalidate(asyncCoachPageControllerProvider);
          Navigator.of(context).pop();
        },
      ),
    );
    ref.listen<AsyncValue<void>>(
      planPhaseChangeButtonProvider,
      (_, state) => state.whenOrNull(
        error: (error, stack) {
          // show snackbar if an error occurred
          GenericSnackBar.showErrorSnackBar(
              context: context, text: error.toString());
        },
        loading: () {},
        data: (_) {
          // rebuild the page to show the new state
          ref.invalidate(asyncPlanPhasePageControllerProvider);
        },
      ),
    );
    final planPhase = ref.watch(asyncPlanPhasePageControllerProvider);
    return planPhase.when(
      data: (data) {
        data.workouts.sort((a, b) => a.order.compareTo(b.order));
        Map<int, List<WorkoutPlanConfig>> groupedWorkouts = {};
        for (var workout in data.workouts) {
          if (!groupedWorkouts.containsKey(workout.order)) {
            groupedWorkouts[workout.order] = [];
          }
          groupedWorkouts[workout.order]!.add(workout);
        }
        return Scaffold(
            backgroundColor: ThemeBase.of(context).primaryBackground,
            appBar: GenericAppBar.build(
              context,
              data.plan.name,
              actions: [
                IconButton(
                    onPressed: () => GenericBottomSheet.showOptions(
                            context: context,
                            items: [
                              {
                                'icon': Icons.stop_circle_outlined,
                                'title': AppLocalizations.of(context)
                                    .planPhasePageStopPlanButton,
                                'onTap': () => ref
                                    .read(planPhaseStopButtonProvider.notifier)
                                    .stopPlan(data.planStatus!.id)
                              },
                              {
                                'icon': Icons.change_circle_outlined,
                                'title': AppLocalizations.of(context)
                                    .planPhasePageNextPhaseButton,
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
                    icon: const Icon(Icons.menu)),
              ],
            ),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        data.planStatus!.phaseTypeAsString,
                        style: ThemeBase.of(context).headlineMedium.copyWith(
                              color: ThemeBase.of(context).primaryText,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
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
                                      ? ThemeBase.of(context).secondary
                                      : const Color(0xFF262424),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          '${AppLocalizations.of(context).planPhasePageFinishedWorkoutsTitle1} ${data.completedWorkoutsCounter} ${AppLocalizations.of(context).planPhasePageFinishedWorkoutsTitle2} ${data.workouts.length}',
                          style: ThemeBase.of(context).bodySmall.copyWith(
                                color: ThemeBase.of(context).secondaryText,
                                fontSize: 10,
                                height: 0,
                              )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.28,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: NetworkImage(data
                              .previewImageUrl), // "https://via.placeholder.com/358x291"
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                    child: Column(
                      children: groupedWorkouts.entries.map((entry) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeBase.of(context).accent4,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: Column(
                            children: entry.value.map((workout) {
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(
                                            selectedWorkoutIdProvider.notifier)
                                        .state = workout.id;
                                    Map<String, String> querys = {
                                      "id": workout.id.toString(),
                                      "difficultyType": data
                                          .planStatus!.difficultyType!.index
                                          .toString()
                                    };
                                    ref
                                        .read(selectedWorkoutQueryProvider
                                            .notifier)
                                        .state = querys;
                                    AppRouter.goToWorkoutDetail(
                                        planStatus: data.planStatus,
                                        planWorkoutId: workout.planWorkoutId);
                                  },
                                  child: WorkoutCardHorizontal(
                                    hasTrained: data.planStatus!.workoutIds
                                        .contains(workout
                                            .planWorkoutId), // Update this based on your logic
                                    workout: WorkoutListItem(
                                      id: workout.id,
                                      name: workout.name,
                                      previewImageUrl: workout.previewImageUrl,
                                      hashtags: workout.hashtags,
                                      likes: workout.likes,
                                      comments: workout.comments,
                                      duration: 20,
                                      isWorkoutOfTheWeek: false,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }).toList(), /* [
                        for (var index = 0;
                            index < data.workouts.length;
                            index++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                ref
                                    .read(selectedWorkoutIdProvider.notifier)
                                    .state = data.workouts[index].id;
                                Map<String, String> querys = {
                                        "id": data.workouts[index].id.toString(),
                                        "difficultyType":
                                            data.planStatus!.difficultyType!.index.toString()
                                      };
                                      ref.read(selectedWorkoutQueryProvider.notifier).state = querys;
                                AppRouter.goToWorkoutDetail(
                                    planStatus: data.planStatus,
                                    planWorkoutId:
                                        data.workouts[index].planWorkoutId);
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
                                  hashtags: data.workouts[index].hashtags,
                                  likes: data.workouts[index].likes,
                                  comments: data.workouts[index].comments,
                                  duration: 20,
                                  isWorkoutOfTheWeek: false,
                                ),
                              ),
                            ),
                          )
                      ], */
                    ),
                  ),
                ],
              ),
            ));
      },
      loading: () => Center(
          child: CircularProgressIndicator(
        strokeWidth: 0.5,
        color: ThemeBase.of(context).primaryText,
      )),
      error: (error, stack) => Center(child: Text(error.toString())),
    );
  }
}
