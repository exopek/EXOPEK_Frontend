import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/HashTagPill.dart';
import 'package:exopek_workout_app/components/WorkoutOverviewCard.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/domain/Models/Exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutDetail extends ConsumerStatefulWidget {
  WorkoutDetail({super.key}) {}

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
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: 1178,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
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
                        ),
                        Positioned(
                          left: 16,
                          top: 385,
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
                        Positioned(
                          left: 16,
                          top: 422,
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
                        Positioned(
                          left: 16,
                          top: 666,
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
                        Positioned(
                            left: 16,
                            right: 16,
                            top: 582,
                            child:
                                CtaButton(label: 'Starten', onPressed: () {})),
                        Positioned(
                          left: 16,
                          top: 851,
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
                        Positioned(
                          left: 16,
                          top: 449,
                          child: SizedBox(
                            width: 350,
                            child: Text(
                              'Get ready to sweat and burn calories with this intense full body workout. It combines cardio and strength exercises to target all major groups.',
                              style: TextStyle(
                                color: Color(0xFF838282),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16.0,
                          top: 509,
                          right: 16.0,
                          child: /* Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: 70,
                              child: */
                              Wrap(
                            //clipBehavior: Clip.antiAlias,
                            //direction: Axis.horizontal,
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (var hashtag
                                  in result.hashtagsList as List<String>)
                                HashTagPill(text: hashtag)
                            ],
                          ),
                          //)
                        ),
                        Positioned(
                            left: 0,
                            top: 697,
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              height: 130,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(left: 16),
                                  itemCount: result.exerciseMap.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
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
                            )),
                        Positioned(
                          left: 16,
                          top: 882,
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
