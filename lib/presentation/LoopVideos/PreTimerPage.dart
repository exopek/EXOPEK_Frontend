import 'package:exopek_workout_app/domain/Models/Exercise.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/LoopVideosPageViewModel.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    _animation = StepTween(begin: 5, end: 0).animate(_animationController)
      ..addListener(() {
        setState(() {
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
      backgroundColor: ThemeBase.of(context).primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.cancel)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Text(
                formatSeconds(_animation.value),
                style: ThemeBase.of(context).headlineLarge.copyWith(
                      color: Colors.white,
                      fontSize: 48.0,
                      fontWeight: FontWeight.w600
                    ),
              ),
            ),
            Text(
              AppLocalizations.of(context).preTimerPageBody1,
              style: ThemeBase.of(context).headlineMedium.copyWith(
                    color: Colors.white,
                  ),  
            ),
          ],
        ),
      ),
    );
  }
}
