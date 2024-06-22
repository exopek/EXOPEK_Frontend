// ignore_for_file: file_names
import 'package:exopek_workout_app/components/Shared/GenericAppBar.dart';
import 'package:exopek_workout_app/components/WorkoutLists/WorkoutCardHorizontal.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/workoutProvider/WorkoutProvider.dart';
import 'package:exopek_workout_app/domain/Models/Enums/DifficultyType.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LikedWorkoutsPage extends ConsumerStatefulWidget {
  const LikedWorkoutsPage({super.key});

  @override
  ConsumerState<LikedWorkoutsPage> createState() => _LikedWorkoutsPageState();
}

class _LikedWorkoutsPageState extends ConsumerState<LikedWorkoutsPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(asyncLikedWorkoutsProvider);
    return result.when(
        data: (result) {
          return Scaffold(
            backgroundColor: ThemeBase.of(context).primaryBackground,
            appBar: GenericAppBar.build(context, AppLocalizations.of(context).likedWorkoutsPageTitle),
            body: result.isEmpty ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context).likedWorkoutsPageNoResults,
                    style: ThemeBase.of(context).bodySmall),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        AppRouter.goToWorkouts();
                      },
                      child: Text(AppLocalizations.of(context).likedWorkoutsdPageGoToWorkoutsButton,
                      style: ThemeBase.of(context).bodySmall.copyWith(
                        color: ThemeBase.of(context).secondary,
                      ),),
                    ),
                  ],
                ),
              ),
            ) : CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextButton(
                          onPressed: () {
                            ref.read(selectedWorkoutIdProvider.notifier).state =
                                result[index].workoutId;
                                Map<String, String> querys = {
                                        "id": result[index].id.toString(),
                                        "difficultyType":
                                            DifficultyType.beginner.index.toString()
                                      };
                                      ref.read(selectedWorkoutQueryProvider.notifier).state = querys;
                            AppRouter.goToWorkoutDetail();
                          },
                          child: WorkoutCardHorizontal(
                            workout: result[index].workout!,
                          ),
                        ),
                      );
                    },
                    childCount: result.length,
                  ),
                ),
              ]),
            
          );
        },
        loading: () => Center(child: CircularProgressIndicator(
          strokeWidth: 0.5,
          color: ThemeBase.of(context).primaryText,
        )),
        error: (e, s) => Center(child: Text(e.toString())));
  }
}
