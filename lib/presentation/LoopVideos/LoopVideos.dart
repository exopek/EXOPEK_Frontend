import 'package:exopek_workout_app/components/NextExerciseCard.dart';
import 'package:exopek_workout_app/dependencyInjection/loopVideosProvider/LoopVideosProvider.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/LoopVideosPageViewModel.dart';
import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/WorkoutSummaryPageViewModel.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:exopek_workout_app/utils/AppVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/Models/Exercise.dart';

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

    timerAnimationController.reset();
    timerAnimationController.increment(sortedExerciseConfig[0].duration);
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
    final exerciseState = ref.watch(loopVideosControllerProvider);
    final timerAnimationValue = ref.watch(timerAnimationControllerProvider);
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFF0C0C0C)),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 533,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    if (exerciseState < sortedExerciseConfig.length - 1) {
                      ref
                          .read(loopVideosControllerProvider.notifier)
                          .increment();
                      ref
                          .read(loopVideosProgressIndicatorControllerProvider
                              .notifier)
                          .increment();
                      ref
                          .read(timerAnimationControllerProvider.notifier)
                          .reset();
                      ref
                          .read(timerAnimationControllerProvider.notifier)
                          .increment(
                              sortedExerciseConfig[exerciseState + 1].duration);

                      setState(() {
                        _animationController.reset();
                        _animationController.duration = Duration(
                            seconds: sortedExerciseConfig[exerciseState + 1]
                                .duration);
                        _animationController.forward(from: 0.0);
                      });
                    } else {
                      /* AppRouter.goToMainPage(); */
                      AppRouter.goToWorkoutSummary(WorkoutSummaryPageViewModel(
                          workoutDetails: widget.viewModel.workoutDetails,
                          planStatus: widget.viewModel.planStatus,
                          planWorkoutId: widget.viewModel.planWorkoutId));
                    }
                  },
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
            Positioned(
              left: 303,
              top: 50,
              child: Text(
                    formatSeconds(_elapsed.inSeconds),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  )
               
            ),
            if (sortedExerciseConfig[exerciseState].duration != 0)
              Positioned(
                  left: 20,
                  top: 550,
                  child: Text(
                    formatSeconds(timerAnimationValue),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            if (sortedExerciseConfig[exerciseState].duration != 0)
              Positioned(
                left: 20,
                right: 20,
                top: 617,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 10,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          left: 0,
                          top: 0,
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
                                      MediaQuery.sizeOf(context).width *
                                      0.899,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFCE2323),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                );
                              }))
                    ],
                  ),
                ),
              ),
            if (sortedExerciseConfig[exerciseState].reps != 0)
              Positioned(
                    left: 20,
                    top: 550,
                    child: Text(
                      "x${sortedExerciseConfig[exerciseState].reps} (Reps)",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    )),
            Positioned(
              left: 20,
              top: 679,
              child: Text(
                sortedExerciseConfig[exerciseState].name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
                left: 20,
                top: 716,
                child: (exerciseState < sortedExerciseConfig.length - 1)
                    ? NextExerciseCard(
                        title: sortedExerciseConfig[exerciseState + 1].name,
                        imageUrl: sortedExerciseConfig[exerciseState + 1]
                            .previewImageUrl,
                        exerciseFrequenceType:
                            sortedExerciseConfig[exerciseState + 1]
                                .duration
                                .toString(),
                      )
                    : Container()),
            Positioned(
              left: 10,
              top: 40,
              child: Container(
                child: IconButton(
                    onPressed: () => AppRouter.goToMainPage(),
                    icon: Icon(Icons.cancel)),
              ),
            ),
            Positioned(
              left: 20,
              top: 805,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var i = 0; i < sortedExerciseConfig.length; i++)
                      Expanded(
                        child: Container(
                          height: 7,
                          decoration: ShapeDecoration(
                            color: (i == exerciseState)
                                ? Color(0xFFCE2323)
                                : Color(0xFFD9D9D9),
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
          ],
        ),
      ),
    );
  }
}
