import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/HashTagPill.dart';
import 'package:exopek_workout_app/components/WorkoutOverviewCard.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/domain/Models/Exercise.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/LoopVideosPageViewModel.dart';
import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/WorkoutDetailPageViewModel.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutDetail extends ConsumerStatefulWidget {
  final WorkoutDetailPageViewModel? viewModel;
  WorkoutDetail({super.key, this.viewModel}) {}

  @override
  ConsumerState<WorkoutDetail> createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends ConsumerState<WorkoutDetail> {
  @override
  Widget build(BuildContext context) {
    final result = ref.watch(workoutSingleProvider);
    return result.when(
        data: (result) {
          return Scaffold(
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
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
                          width: 390,
                          height: 370,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(result
                                  .previewImageUrl /* "https://via.placeholder.com/390x370" */),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, bottom: 8, top: 8),
                          child: Text(
                            result.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                          child: Text(
                            'Intensity: High',
                            style: TextStyle(
                              color: Color(0xFFD31919),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                          child: SizedBox(
                            width: 350,
                            child: Text(
                              result.description,
                              style: TextStyle(
                                color: Color(0xFF838282),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                          child: Wrap(
                            //clipBehavior: Clip.antiAlias,
                            //direction: Axis.horizontal,
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (var hashtag
                                  in result.hashtagsList as List<String>)
                                IntrinsicWidth(
                                    child: HashTagPill(text: hashtag))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, bottom: 8, top: 8),
                          child: CtaButton(
                              label: 'Starten',
                              onPressed: () => AppRouter.goToVideoLoops(
                                  LoopVideosPageViewModel(
                                      workoutDetails: result,
                                      planStatus: widget.viewModel?.planStatus,
                                      planWorkoutId:
                                          widget.viewModel?.planWorkoutId))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 8, bottom: 8),
                          child: Text(
                            'Workout-Ablauf',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: 130,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(left: 16),
                                itemCount: result.exerciseMap.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: WorkoutOverviewCard(
                                      round: index,
                                      excerciseWorkoutConfig: result
                                                  .exerciseMap[
                                              result.sortedCurrentStageTypes[
                                                  index]]
                                          as List<ExcerciseWorkoutConfig>,
                                      stageType:
                                          result.currentStageTypes[index],
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                          child: Text(
                            'Focus',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: Container(
                            width: 355,
                            height: 296,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(result.muscleImageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
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
