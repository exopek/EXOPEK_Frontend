import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/dependencyInjection/plansProvider/PlansProvider.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/WorkoutSummaryPageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/AppRouter.dart';

class WorkoutSummaryPage extends ConsumerStatefulWidget {
  final WorkoutSummaryPageViewModel viewModel;
  const WorkoutSummaryPage({super.key, required this.viewModel});

  @override
  ConsumerState<WorkoutSummaryPage> createState() => _WorkoutSummaryPageState();
}

class _WorkoutSummaryPageState extends ConsumerState<WorkoutSummaryPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(asyncWorkoutSummarySaveButtonControllerProvider,
        (previous, next) {
      if (next is AsyncData) {
        AppRouter.goToMainPage();
      }
    });
    final state = ref.watch(asyncWorkoutSummarySaveButtonControllerProvider);
    return Scaffold(

        /* TextButton(
              onPressed: () {
                if (widget.viewModel.planStatus != null) {
                  List<String> workoutIds =
                      widget.viewModel.planStatus!.workoutIds.toList();
                  workoutIds.add(widget.viewModel.planWorkoutId!);
                  ref
                      .read(asyncWorkoutSummarySaveButtonControllerProvider
                          .notifier)
                      .saveWorkoutAndUpdatePlanStatus(
                          id: widget.viewModel.planStatus!.id,
                          status: widget.viewModel.planStatus!.statusTypeAsType,
                          phase: widget.viewModel.planStatus!.phaseTypeAsType,
                          workoutIds: workoutIds,
                          workoutId: widget.viewModel.workoutDetails.id);
                } else {
                  ref
                      .read(asyncWorkoutSummarySaveButtonControllerProvider
                          .notifier)
                      .saveWorkout(widget.viewModel.workoutDetails.id);
                }
                //AppRouter.goToMainPage();
              },
              child: Text("Speichern und Beenden")), */
        body: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 370,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 370,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/pexels-li-sun-2294361.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 370,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5299999713897705),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 94,
                    top: 95,
                    child: Text(
                      'WELL DONE!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 106,
                    top: 146,
                    child: Text(
                      'Routine completed',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'How did you feel?',
                  style: TextStyle(
                    color: Color(0xFF838282),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            Container(
              width: 390,
              height: 94,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.sentiment_very_dissatisfied_outlined,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.sentiment_dissatisfied_outlined,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.sentiment_neutral_outlined,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.sentiment_very_satisfied_outlined,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Notes',
                  style: TextStyle(
                    color: Color(0xFF838282),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            Container(
              width: 390,
              height: 94,
              decoration: BoxDecoration(color: Color(0x23D9D9D9)),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 100),
                child: CtaButton(
                    label: 'Beenden und Speichern',
                    isLoading: state is AsyncLoading,
                    onPressed: () {
                      if (widget.viewModel.planStatus != null) {
                        List<String> workoutIds =
                            widget.viewModel.planStatus!.workoutIds.toList();
                        workoutIds.add(widget.viewModel.planWorkoutId!);
                        ref
                            .read(
                                asyncWorkoutSummarySaveButtonControllerProvider
                                    .notifier)
                            .saveWorkoutAndUpdatePlanStatus(
                                id: widget.viewModel.planStatus!.id,
                                status: widget
                                    .viewModel.planStatus!.statusTypeAsType,
                                phase: widget
                                    .viewModel.planStatus!.phaseTypeAsType,
                                workoutIds: workoutIds,
                                workoutId: widget.viewModel.workoutDetails.id);
                      } else {
                        ref
                            .read(
                                asyncWorkoutSummarySaveButtonControllerProvider
                                    .notifier)
                            .saveWorkout(widget.viewModel.workoutDetails.id);
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
