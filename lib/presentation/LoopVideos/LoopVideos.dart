import 'package:exopek_workout_app/components/NextExerciseCard.dart';
import 'package:exopek_workout_app/dependencyInjection/loopVideosProvider/LoopVideosProvider.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/LoopVideosPageViewModel.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/WorkoutSummaryPageViewModel.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:exopek_workout_app/utils/AppVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/Models/Exercise.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoopVideos extends ConsumerStatefulWidget {
  final LoopVideosPageViewModel viewModel;

  const LoopVideos({
    super.key,
    required this.viewModel,
  });

  @override
  ConsumerState<LoopVideos> createState() => _LoopVideosState();
}

class _LoopVideosState extends ConsumerState<LoopVideos>
    with TickerProviderStateMixin {
  late List<ExcerciseWorkoutConfig> sortedExerciseConfig;
  late AnimationController _animationController;
  late Animation<double> sizeAnimation;
  Duration _elapsed = Duration.zero;
  late final Ticker _ticker;

  String formatSeconds(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  void _nextExercise(int exerciseState) {
    ref.read(loopVideosControllerProvider.notifier).increment();
    ref
        .read(loopVideosProgressIndicatorControllerProvider.notifier)
        .increment();
    ref.read(timerAnimationControllerProvider.notifier).reset(sortedExerciseConfig[exerciseState + 1].duration);
    ref
        .read(timerAnimationControllerProvider.notifier)
        .decrement();

    setState(() {
      _animationController.reset();
      _animationController.duration =
          Duration(seconds: sortedExerciseConfig[exerciseState + 1].duration);
      _animationController.forward(from: 0.0);
    });
  }

  @override
  void initState() {
    super.initState();
    _ticker = this.createTicker((elapsed) {
      setState(() {
        _elapsed = elapsed;
      });
    });
    _ticker.start();

    sortedExerciseConfig = widget.viewModel.workoutDetails.sortedExercises
        as List<ExcerciseWorkoutConfig>;
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: sortedExerciseConfig[0].duration));
    _animationController.forward(from: 0.0);
    sizeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    ref.read(loopVideosControllerProvider.notifier).reset();

    final timerAnimationController =
        ref.read(timerAnimationControllerProvider.notifier);

    timerAnimationController.reset(sortedExerciseConfig[0].duration);

    timerAnimationController.decrement();

  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(timerAnimationControllerProvider, (previous, next) {
      final exerciseState = ref.watch(loopVideosControllerProvider);
      if (next == 0 &&
          exerciseState < sortedExerciseConfig.length - 1) {
        _nextExercise(exerciseState);
      }
     });
    final exerciseState = ref.watch(loopVideosControllerProvider);
    final timerAnimationValue = ref.watch(timerAnimationControllerProvider);
    return Scaffold(
      backgroundColor: ThemeBase.of(context).primaryBackground,
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (exerciseState < sortedExerciseConfig.length - 1) {
                _nextExercise(exerciseState);
                
              } else {
                AppRouter.goToWorkoutSummary(WorkoutSummaryPageViewModel(
                    workoutDetails: widget.viewModel.workoutDetails,
                    planStatus: widget.viewModel.planStatus,
                    planWorkoutId: widget.viewModel.planWorkoutId));
              }
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.5,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height * 0.5,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      child: ClipRRect(
                        child: AppVideoPlayer(
                          path: sortedExerciseConfig[exerciseState].videoUrl,
                          videoType: VideoType.network,
                          looping: true,
                          showControls: false,
                          autoPlay: true,
                        ),
                      ),
                    ),
                  ),
                  if (sortedExerciseConfig[exerciseState].isRest)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context).loopVideosPagePauseText1,
                              style:
                                  ThemeBase.of(context).headlineMedium.copyWith(
                                        fontSize: 48,
                                        color: Colors.white,
                                      ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context).loopVideosPagePauseText2,
                              style:
                                  ThemeBase.of(context).headlineMedium.copyWith(
                                        fontSize: 48,
                                        color: Colors.white,
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Positioned(
                      right: 16,
                      top: 50,
                      child: Text(
                        formatSeconds(_elapsed.inSeconds),
                        style: ThemeBase.of(context).headlineMedium.copyWith(
                              fontSize: 24,
                              color: Colors.white,
                            )
                      )),
                  Positioned(
                    left: 16,
                    top: 55,
                    child: SizedBox(
                      child: GestureDetector(
                          onTap: () => AppRouter.goToMainPage(),
                          child: const Icon(Icons.cancel)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                sortedExerciseConfig[exerciseState].name,
                style: ThemeBase.of(context).headlineMedium.copyWith(
                      fontSize: 24,
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          if (sortedExerciseConfig[exerciseState].duration != 0)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  formatSeconds(timerAnimationValue),
                  style: ThemeBase.of(context).headlineMedium.copyWith(
                        fontSize: 48,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          if (sortedExerciseConfig[exerciseState].duration != 0)
            Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: AnimatedBuilder(
                    animation: sizeAnimation,
                    child: Container(
                      height: 10,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    builder: (BuildContext context, Widget? child) {
                      return Container(
                        height: 10,
                        width: sizeAnimation.value *
                            MediaQuery.sizeOf(context).width,
                        decoration: ShapeDecoration(
                          color: sortedExerciseConfig[exerciseState].isRest
                              ? Colors.blue
                              : ThemeBase.of(context).secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      );
                    })),
          if (sortedExerciseConfig[exerciseState].reps != 0)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "x${sortedExerciseConfig[exerciseState].reps}",
                      style: ThemeBase.of(context).headlineMedium.copyWith(
                          fontSize: 48, color: Colors.white, height: 0),
                    ),
                    Text(
                      AppLocalizations.of(context).loopVideosPageReps,
                      style: ThemeBase.of(context).titleSmall,
                    ),
                  ],
                ),
              ),
            ),
          (exerciseState < sortedExerciseConfig.length - 1)
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: NextExerciseCard(
                    title: sortedExerciseConfig[exerciseState + 1].name,
                    imageUrl:
                        sortedExerciseConfig[exerciseState + 1].previewImageUrl,
                    exerciseFrequenceType:
                        sortedExerciseConfig[exerciseState + 1]
                            .duration
                            .toString(),
                    reps:
                        sortedExerciseConfig[exerciseState + 1].reps.toString(),
                    isRest: sortedExerciseConfig[exerciseState + 1].isRest,
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: NextExerciseCard(
                    title: AppLocalizations.of(context).loopVideosPageFinish,
                    imageUrl: null,
                    exerciseFrequenceType: "",
                    reps: "",
                    isRest: false,
                  ),
                ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 44.0),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var i = 0; i < sortedExerciseConfig.length; i++)
                      Expanded(
                        child: Container(
                          height: 7,
                          decoration: ShapeDecoration(
                            color: (i == exerciseState)
                                ? sortedExerciseConfig[exerciseState].isRest
                                    ? Colors.blue
                                    : ThemeBase.of(context).secondary
                                : const Color(0xFFD9D9D9),
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
          ),
        ],
      ),
    );
  }
}
