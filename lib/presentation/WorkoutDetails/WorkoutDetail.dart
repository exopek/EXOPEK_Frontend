import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/HashTagPill.dart';
import 'package:exopek_workout_app/components/Shared/GenericAppBar.dart';
import 'package:exopek_workout_app/components/Shared/RatingStars.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/workoutProvider/WorkoutProvider.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/LoopVideosPageViewModel.dart';
import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:exopek_workout_app/utils/AppUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/WorkoutDetailPage/CommentRatingCard.dart';
import '../../components/WorkoutDetailPage/ExerciseInfoCard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          var distinctExercises = result.workout.exercises
              .distinct((a, b) => a.name == b.name)
              .toList();
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: GenericAppBar.build(context, "", hasDivider: false),
            backgroundColor: ThemeBase.of(context).primaryBackground,
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
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
                          style: ThemeBase.of(context).headlineSmall.copyWith(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                        child: Text(
                          '${AppLocalizations.of(context).workoutDetailsPageHeadlineLevel} ${result.workout.difficultyType.name.toUpperCase()}',
                          style: ThemeBase.of(context).headlineSmall.copyWith(
                              color: ThemeBase.of(context).secondary,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                        child: SizedBox(
                          width: 350,
                          child: Text(
                            result.workout.description,
                            style: ThemeBase.of(context).bodySmall.copyWith(
                                  color: ThemeBase.of(context).secondaryText,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (var hashtag
                                in result.workout.hashtagsList as List<String>)
                              IntrinsicWidth(child: HashTagPill(text: hashtag))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16, bottom: 8, top: 8),
                        child: CtaButton(
                            label: AppLocalizations.of(context). workoutDetailsPageStartWorkoutButton,
                            onPressed: () => AppRouter.goToPreTimer(
                                LoopVideosPageViewModel(
                                    workoutDetails: result.workout,
                                    planStatus: widget.planStatus,
                                    planWorkoutId: widget.planWorkoutId))),
                      ),
                      if (result.comments.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, bottom: 8, top: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context).workoutDetailsPageHeadlineRatings,
                                style: ThemeBase.of(context).headlineSmall,
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
                                (result.comments.fold(
                                            0,
                                            (previousValue, element) =>
                                                previousValue +
                                                int.parse(element.rating
                                                    .toString())) /
                                        result.comments.length)
                                    .toStringAsFixed(1),
                                style: ThemeBase.of(context).headlineLarge,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              RatingStars(
                                size: 26,
                                rating: (result.comments.fold(
                                        0,
                                        (previousValue, element) =>
                                            previousValue +
                                            int.parse(
                                                element.rating.toString())) /
                                    result.comments.length),
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
                              for (var comment in result.comments
                                  .where(
                                      (element) => element.comment!.isNotEmpty)
                                  .take(3))
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
                              label: AppLocalizations.of(context).workoutDetailsPageAllRatingsButton,
                              color: ThemeBase.of(context).accent4,
                              onPressed: () {
                                ref
                                    .read(selectedWorkoutIdProvider.notifier)
                                    .state = result.workout.id;
                                AppRouter.goToComments();
                              }),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 8, bottom: 16),
                        child: Text(
                          AppLocalizations.of(context).workoutDetailsPageHeadlineExercises,
                          style: ThemeBase.of(context).headlineSmall,
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        width: MediaQuery.sizeOf(context).width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: distinctExercises.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16, bottom: 8),
                              child: ExerciseInfoCard(
                                name: distinctExercises[index].name,
                                sets: '',
                                duration: '',
                                imageUrl:
                                    distinctExercises[index].previewImageUrl,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 46,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => Center(
                child: CircularProgressIndicator(
              strokeWidth: 0.5,
              color: ThemeBase.of(context).primaryText,
            )),
        error: (e, s) => Center(child: Text(e.toString())));
  }
}
