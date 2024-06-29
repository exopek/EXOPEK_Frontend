import 'package:exopek_workout_app/components/HashTagPill.dart';
import 'package:exopek_workout_app/components/Shared/GenericAppBar.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/workoutProvider/WorkoutProvider.dart';
import 'package:exopek_workout_app/domain/Models/Enums/DifficultyType.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:exopek_workout_app/utils/AppVideoPlayer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HighlightsWorkoutsPage extends ConsumerStatefulWidget {
  const HighlightsWorkoutsPage({super.key});

  @override
  ConsumerState<HighlightsWorkoutsPage> createState() =>
      _HighlightsWorkoutsPageState();
}

class _HighlightsWorkoutsPageState
    extends ConsumerState<HighlightsWorkoutsPage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(asyncWorkoutsPageControllerProvider);
    final selectedWorkoutQuery = ref.watch(selectedWorkoutQueryProvider);
    return provider.when(
      data: (result) {
        return Scaffold(
          appBar: GenericAppBar.build(
              context,
              selectedWorkoutQuery.keys.contains('isNew')
                  ? AppLocalizations.of(context).workoutHighlightsNewTitle
                  : AppLocalizations.of(context)
                      .workoutHighlightsBestRatedTitle),
          backgroundColor: ThemeBase.of(context).primaryBackground,
          extendBodyBehindAppBar: true,
          body: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: result.workouts.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        child: ClipRRect(
                          child: AppVideoPlayer(
                            path: result.workouts[index].videoUrl!,
                            videoType: VideoType.network,
                            looping: true,
                            showControls: false,
                            autoPlay: true,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            ref.read(selectedWorkoutIdProvider.notifier).state =
                                result.workouts[index].id;
                            Map<String, String> querys = {
                              "id": result.workouts[index].id.toString(),
                              "difficultyType":
                                  DifficultyType.beginner.index.toString()
                            };
                            ref
                                .read(selectedWorkoutQueryProvider.notifier)
                                .state = querys;
                            AppRouter.goToWorkoutDetail();
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: 180,
                            decoration: ShapeDecoration(
                              color: Color(0xFF262424).withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    result.workouts[index].name,
                                    textAlign: TextAlign.left,
                                    style: ThemeBase.of(context)
                                        .headlineSmall
                                        .copyWith(
                                          color:
                                              ThemeBase.of(context).primaryText,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 4.0),
                                  child: Text(
                                    result.workouts[index].description ?? '',
                                    textAlign: TextAlign.left,
                                    style: ThemeBase.of(context)
                                        .bodySmall
                                        .copyWith(
                                          color:
                                              ThemeBase.of(context).primaryText,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      top: 12.0,
                                      bottom: 8.0,
                                      right: 8.0),
                                  child: Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      for (var hashtag in (result
                                              .workouts[index]
                                              .hashtagsList as List<String>)
                                          .take(3))
                                        IntrinsicWidth(
                                            child: HashTagPill(
                                          text: hashtag,
                                          color: ThemeBase.of(context)
                                              .secondaryBackground,
                                        ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                );
              },
            ),
          ),
        );
      },
      loading: () => const Center(
          child: CircularProgressIndicator(
        strokeWidth: 0.5,
        color: Colors.white,
      )),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
