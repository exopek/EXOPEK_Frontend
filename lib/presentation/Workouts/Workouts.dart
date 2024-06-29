// ignore_for_file: file_names
import 'package:exopek_workout_app/components/PromoHeader.dart';
import 'package:exopek_workout_app/components/SearchBarCustom.dart';
import 'package:exopek_workout_app/components/Shared/GenericAppBar.dart';
import 'package:exopek_workout_app/components/WorkoutLists/WorkoutCardHorizontal.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/workoutProvider/WorkoutProvider.dart';
import 'package:exopek_workout_app/domain/Models/Enums/DifficultyType.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Workouts extends ConsumerStatefulWidget {
  const Workouts({super.key});

  @override
  ConsumerState<Workouts> createState() => _WorkoutsState();
}

class _WorkoutsState extends ConsumerState<Workouts> {

  @override
  void initState() {
    // listener for SliverAppBar height

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(workoutProvider);
    return result.when(
        data: (result) {
          return Scaffold(
            backgroundColor: ThemeBase.of(context).primaryBackground,
            appBar: GenericAppBar.build(context, AppLocalizations.of(context).workoutsPageTitle),
            body: CustomScrollView(slivers: [
                /* SliverAppBar(
                  leading: Container(),
                  expandedHeight: 329,
                  collapsedHeight: 200,
                  
                  floating: true,
                  flexibleSpace: PromoHeader(
                    workout: result.firstWhere(
                        (element) => element.isWorkoutOfTheWeek == true),
                  ),
                ), */
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextButton(
                          onPressed: () {
                            ref.read(selectedWorkoutIdProvider.notifier).state =
                                result[index].id;
                                Map<String, String> querys = {
                                        "id": result[index].id.toString(),
                                        "difficultyType":
                                            DifficultyType.beginner.index.toString()
                                      };
                                      ref.read(selectedWorkoutQueryProvider.notifier).state = querys;
                            AppRouter.goToWorkoutDetail();
                          },
                          child: WorkoutCardHorizontal(
                            workout: result[index],
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
