import 'dart:async';
import 'dart:ffi';

import 'package:exopek_workout_app/components/NextExerciseCard.dart';
import 'package:exopek_workout_app/domain/Models/Exercise.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/LoopVideosPageViewModel.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';

class PreTimerPage extends StatefulWidget {
  final LoopVideosPageViewModel viewModel;
  const PreTimerPage({super.key, required this.viewModel});

  @override
  State<PreTimerPage> createState() => _PreTimerPageState();
}

class _PreTimerPageState extends State<PreTimerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _animation;
  late List<ExcerciseWorkoutConfig> sortedExerciseConfig;

  @override
  void initState() {
    super.initState();
    sortedExerciseConfig = widget.viewModel.workoutDetails.sortedExercises
        as List<ExcerciseWorkoutConfig>;
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));

    _animation = StepTween(begin: 10, end: 0).animate(_animationController)
      ..addListener(() {
        setState(() {
          // setState aufrufen, um das Widget neu zu zeichnen
        });
      });
    _animationController.forward();
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        AppRouter.goToVideoLoops(widget.viewModel);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String formatSeconds(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 40,
              child: Container(
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.cancel)),
              ),
            ),
            Positioned(
              left: 123,
              top: 336,
              child: Text(
                formatSeconds(_animation.value),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 679,
              child: Text(
                "Dein nächstes Workout",
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
                child: NextExerciseCard(
                  title: sortedExerciseConfig[0].name,
                  imageUrl: sortedExerciseConfig[0].previewImageUrl,
                  exerciseFrequenceType:
                      sortedExerciseConfig[0].duration.toString(),
                )),
            Positioned(
              left: 65,
              top: 285,
              child: Text(
                'Mach dich bereit',
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
                            color: Color(0xFFD9D9D9),
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
