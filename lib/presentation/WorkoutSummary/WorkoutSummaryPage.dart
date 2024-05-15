import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/dependencyInjection/coachProvider/coachPageControllerProvider.dart';
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

  TextEditingController _notesController = TextEditingController();
  late int _rating;

  @override
  void initState() {
    _rating = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(asyncWorkoutSummarySaveButtonControllerProvider,
        (previous, next) {
      if (next is AsyncData) {
        ref.invalidate(asyncCoachPageControllerProvider);
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
                  'How do you rate this workout?',
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
                    onPressed: () {
                      setState(() {
                        _rating = 1;
                      });
                    },
                    child: Icon(
                      _rating == 1 || _rating == 2 || _rating == 3 || _rating == 4 || _rating == 5 ? Icons.star : Icons.star_border,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _rating = 2;
                      });
                    },
                    child: Icon(
                      _rating == 2 || _rating == 3 || _rating == 4 || _rating == 5 ? Icons.star : Icons.star_border,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _rating = 3;
                      });
                    },
                    child: Icon(
                      _rating == 3 || _rating == 4 || _rating == 5 ? Icons.star : Icons.star_border,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _rating = 4;
                      });
                    },
                    child: Icon(
                      _rating == 4 || _rating == 5 ? Icons.star : Icons.star_border,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _rating = 5;
                      });
                    },
                    child: Icon(
                      _rating == 5 ? Icons.star : Icons.star_border,
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
                  'Comments',
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
              width: MediaQuery.of(context).size.width,
              height: 94,
              decoration: BoxDecoration(color: Color(0x23D9D9D9)),
              child: TextField(
                controller: _notesController,
                maxLength: 40,
                maxLines: 3,
                
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 16),
                  border: InputBorder.none,
                  hintText: 'Write your comment here',
                  hintStyle: TextStyle(
                    color: Color(0xFF838282),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
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
                      if (_notesController.text.isNotEmpty && _rating == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Please rate the workout before saving')));
                        return;
                      }
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
                                workoutId: widget.viewModel.workoutDetails.id,
                                comment: _notesController.text,
                                rating: _rating);
                      } else {
                        ref
                            .read(
                                asyncWorkoutSummarySaveButtonControllerProvider
                                    .notifier)
                            .saveWorkout(widget.viewModel.workoutDetails.id, comment: _notesController.text, rating: _rating);
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
