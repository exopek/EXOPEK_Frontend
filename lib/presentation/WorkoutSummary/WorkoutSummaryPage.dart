import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/GenericSnackBar.dart';
import 'package:exopek_workout_app/dependencyInjection/coachProvider/coachPageControllerProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/plansProvider/PlansProvider.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/WorkoutSummaryPageViewModel.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
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
  final TextEditingController _notesController = TextEditingController();
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
        backgroundColor: ThemeBase.of(context).primaryBackground,
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.viewModel.workoutDetails.previewImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Glückwunsch!',
                        style: ThemeBase.of(context).headlineMedium.copyWith(
                              color: ThemeBase.of(context).primaryText,
                            ),
                      ),
                      Text(
                        'Workout abgeschlossen!',
                        style: ThemeBase.of(context).headlineSmall,
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
                      'Wie bewertest du das Workout?',
                      style: ThemeBase.of(context).headlineSmall.copyWith(
                            color: ThemeBase.of(context).secondaryText,
                          )
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
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
                          _rating == 1 ||
                                  _rating == 2 ||
                                  _rating == 3 ||
                                  _rating == 4 ||
                                  _rating == 5
                              ? Icons.star
                              : Icons.star_border,
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
                          _rating == 2 ||
                                  _rating == 3 ||
                                  _rating == 4 ||
                                  _rating == 5
                              ? Icons.star
                              : Icons.star_border,
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
                          _rating == 3 || _rating == 4 || _rating == 5
                              ? Icons.star
                              : Icons.star_border,
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
                          _rating == 4 || _rating == 5
                              ? Icons.star
                              : Icons.star_border,
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
                      'Wie fühlst du dich?',
                      style: ThemeBase.of(context).headlineSmall.copyWith(
                            color: ThemeBase.of(context).secondaryText,
                          ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130.0,
                  decoration: BoxDecoration(color: ThemeBase.of(context).secondaryBackground),
                  child: TextField(
                    controller: _notesController,
                    maxLength: 140,
                    maxLines: 4,
                    style: ThemeBase.of(context).headlineSmall.copyWith(
                            color: ThemeBase.of(context).primaryText,
                            fontSize: 16.0
                          ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 16, top: 2.0, right: 16.0, bottom: 2.0),
                      border: InputBorder.none,
                      hintText: 'Schreibe etwas...',
                      hintStyle: ThemeBase.of(context).headlineSmall.copyWith(
                            color: ThemeBase.of(context).secondaryText,
                            fontSize: 16.0
                          ),
                    ),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 50.0),
                    child: CtaButton(
                        label: 'Beenden und Speichern',
                        isLoading: state is AsyncLoading,
                        onPressed: () {
                          if (_notesController.text.isNotEmpty && _rating == 0) {
                            GenericSnackBar.showErrorSnackBar(
                                context: context,
                                text: 'Bitte bewerte das Workout bevor du es speicherst.',
                                );
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
                                .saveWorkout(widget.viewModel.workoutDetails.id,
                                    comment: _notesController.text,
                                    rating: _rating);
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
