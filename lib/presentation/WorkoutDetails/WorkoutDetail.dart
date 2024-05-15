import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/GenericBottomSheet.dart';
import 'package:exopek_workout_app/components/HashTagPill.dart';
import 'package:exopek_workout_app/components/Shared/RatingStars.dart';
import 'package:exopek_workout_app/components/WorkoutOverviewCard.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/workoutProvider/WorkoutProvider.dart';
import 'package:exopek_workout_app/domain/Models/Exercise.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/LoopVideosPageViewModel.dart';
import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/WorkoutDetailPageViewModel.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/WorkoutDetailPage/CommentRatingCard.dart';

class WorkoutDetail extends ConsumerStatefulWidget {
  final PlanStatus? planStatus;
  final String? planWorkoutId;
  const WorkoutDetail({super.key, this.planStatus, this.planWorkoutId});

  @override
  ConsumerState<WorkoutDetail> createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends ConsumerState<WorkoutDetail> {
  @override
  Widget build(BuildContext context) {
    final result = ref.watch(asyncWorkoutDetailPageControllerProvider);
    return result.when(
        data: (result) {
          return Scaffold(
            backgroundColor: Color(0xFF0C0C0C),
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
                          width: MediaQuery.sizeOf(context).width,
                          height: 370,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(result.workout
                                  .previewImageUrl /* "https://via.placeholder.com/390x370" */),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, bottom: 8, top: 8),
                          child: Text(
                            result.workout.name,
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
                            'Level: ${result.workout.difficultyType.name.toUpperCase()}',
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
                              result.workout.description,
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
                                  in result.workout.hashtagsList as List<String>)
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
                              onPressed: () => AppRouter.goToPreTimer(
                                  LoopVideosPageViewModel(
                                      workoutDetails: result.workout,
                                      planStatus: widget.planStatus,
                                      planWorkoutId:
                                          widget.planWorkoutId))),
                        ),
                        if (result.comments.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16, bottom: 8, top: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Bewertungen',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            
                              ],
                            ),
                          ),
                        if (result.comments.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16, bottom: 16),
                            child: Row(
                              children: [
                                Text(
                                  (result.comments.fold(0, (previousValue, element) => previousValue + int.parse(element.rating.toString())) / result.comments.length).toStringAsFixed(1),
                                  style: ThemeBase.of(context).headlineLarge,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                RatingStars(
                                  size: 26,
                                  rating: (result.comments.fold(0, (previousValue, element) => previousValue + int.parse(element.rating.toString())) / result.comments.length),
                                ),
                              ],
                            ),
                          ),
                        if (result.comments.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16, bottom: 8),
                            child: Divider(
                              color: ThemeBase.of(context).secondaryText,
                              height: 10,
                              thickness: 1,
                          ),
                          ),
                        if (result.comments.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, right: 16),
                            child: Column(
                              children: [
                                for (var comment in result.comments.where((element) => element.comment!.isNotEmpty).take(3))
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: CommentRatingCard(
                                      comment: comment,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        if (result.comments.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16, bottom: 8, top: 8),
                            child: CtaButton(
                                label: 'Alle Kommentare',
                                onPressed: () {
                                  ref.read(selectedWorkoutIdProvider.notifier).state =
                                      result.workout.id;
                                  AppRouter.goToComments();
                                }),
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
                          padding: const EdgeInsets.only(left: 0.0, bottom: 24),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: 130,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(left: 16),
                                itemCount: result.workout.exerciseMap.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      GenericBottomSheet.showRoundInfo(context: context, title: "Runde ${index+1}", excerciseWorkoutConfig: result.workout.exerciseMap[result.workout.sortedCurrentStageTypes[index]] as List<ExcerciseWorkoutConfig>);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: WorkoutOverviewCard(
                                        round: index,
                                        excerciseWorkoutConfig: result.workout
                                                    .exerciseMap[
                                                result.workout.sortedCurrentStageTypes[
                                                    index]]
                                            as List<ExcerciseWorkoutConfig>,
                                        stageType:
                                            result.workout.currentStageTypes[index],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        /* Padding(
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
                                image: NetworkImage(result.workout.muscleImageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ), */
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
