import 'package:exopek_workout_app/components/WorkoutCard.dart';
import 'package:exopek_workout_app/components/WorkoutCardHorizontal.dart';
import 'package:flutter/material.dart';

import '../../domain/Models/Plan.dart';
import '../../domain/Models/Workout.dart';

class PlanPhasePage extends StatefulWidget {
  const PlanPhasePage({super.key, required this.planPhase});

  final PlanPhase planPhase;
  //final List<WorkoutPlanConfig>? workoutPlanConfig;

  @override
  State<PlanPhasePage> createState() => _PlanPhasePageState();
}

class _PlanPhasePageState extends State<PlanPhasePage> {
  /*  WorkoutPlanConfig get currentWorkoutPlanConfig =>
      widget.workoutPlanConfig![0]; */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0C0C0C),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: 844,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
            child: Stack(
              children: [
                Positioned(
                  left: 16,
                  top: 44,
                  child: Text(
                    'Phase 1: Die Basics',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 103,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width - 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i = 0;
                            i < widget.planPhase.workouts.length;
                            i++)
                          Expanded(
                            child: Container(
                              height: 7,
                              decoration: ShapeDecoration(
                                color: (i <
                                        int.parse(widget
                                            .planPhase.completedWorkoutsCounter
                                            .toString()))
                                    ? Color(0xFFCE2323)
                                    : Color(0xFF262424),
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
                Positioned(
                  left: 16,
                  top: 118,
                  child: Text(
                    'Abgeschlossene Workouts: ${widget.planPhase.completedWorkoutsCounter} von ${widget.planPhase.workouts.length}',
                    style: TextStyle(
                      color: Color(0xFF838282),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 165,
                  child: Container(
                    width: 358,
                    height: 291,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.planPhase
                            .previewImageUrl), // "https://via.placeholder.com/358x291"
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 476,
                  left: 16,
                  child: Column(
                    children: [
                      for (var index = 0;
                          index < widget.planPhase.workouts.length;
                          index++)
                        WorkoutCardHorizontal(
                          hasTrained: widget.planPhase.plan.workoutIds
                              .contains(widget.planPhase.workouts[index].id),
                          workout: WorkoutListItem(
                              id: widget.planPhase.workouts[index].id,
                              name: widget.planPhase.workouts[index].name,
                              previewImageUrl: widget
                                  .planPhase.workouts[index].previewImageUrl,
                              hashtags: "hashtags",
                              duration: 20),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
