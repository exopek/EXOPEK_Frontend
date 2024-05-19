import 'package:exopek_workout_app/components/PlanDetailPage/PhaseInfoCard.dart';
import 'package:exopek_workout_app/components/WorkoutDetailPage/ExerciseInfoCard.dart';
import 'package:exopek_workout_app/domain/Models/Exercise.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenericBottomSheet {
  static void showStringList({
    required BuildContext context,
    required List<String> items,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(items[index]),
                onTap: () {
                  Navigator.pop(context, items[index]);
                },
              );
            },
          ),
        );
      },
    );
  }

  static void showOptions({
    required BuildContext context,
    required List<Map<String, dynamic>> items,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 150,
          decoration: BoxDecoration(
            color: Color(0xFF212326),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.white,
              height: 1,
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(items[index]['icon'] as IconData?),
                title: Text(items[index]['title'].toString()),
                onTap: () {
                  (items[index]['onTap'] as void Function())();
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  static void showPhaseInfo({
    required BuildContext context,
    required String title,
    required List<WorkoutPlanConfig> workoutPlanConfig,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
    width: MediaQuery.of(context).size.width,
    height: 534,
    child: Stack(
        children: [
            Positioned(
                left: 0,
                top: 0,
                child: Container(
                    width: 390,
                    height: 534,
                    decoration: const ShapeDecoration(
                        color: Color(0xFF212326),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                            ),
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 16,
                top: 185,
                child: Container(
                    width: 359,
                    height: 225,
                    decoration: const ShapeDecoration(
                        color: Color(0xFF0C0C0C),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                            ),
                        ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      
                      child: ListView.separated(
                        padding: EdgeInsets.only(left: 16, right: 16),
                          separatorBuilder: (context, index) {
                              return const SizedBox(
                                  width: 8,
                                  height: 1,
                              );
                          },
                          itemCount: workoutPlanConfig.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                              return PhaseInfoCard(name: workoutPlanConfig[index].name);
                          },
                      ),
                    ),
                ),
            ),
            Positioned(
                left: 37,
                top: 61,
                child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                    ),
                ),
            ),
            Positioned(
                left: 161,
                top: 25,
                child: Container(
                    width: 67,
                    height: 6,
                    decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 16,
                top: 134,
                child: Container(
                    width: 359,
                    height: 51,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 359,
                                    height: 51,
                                    decoration: const ShapeDecoration(
                                        color: Color(0xFF212326),
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(width: 1, color: Color(0xFF161719)),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                            ),
                                        ),
                                        shadows: [
                                            BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 4),
                                                spreadRadius: 0,
                                            )
                                        ],
                                    ),
                                ),
                            ),
                            const Positioned(
                                left: 29,
                                top: 12,
                                child: Row(
                                  children: [
                                    Icon(Icons.menu_book, color: Colors.white, size: 24,),
                                    SizedBox(width: 8,),
                                    Text(
                                        'Übungen',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                        ),
                                    ),
                                  ],
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        ],
    ),
);
      },
    );
  }

  static void showRoundInfo({
    required BuildContext context,
    required String title,
    required List<ExcerciseWorkoutConfig> excerciseWorkoutConfig,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
    width: MediaQuery.of(context).size.width,
    height: 534,
    child: Stack(
        children: [
            Positioned(
                left: 0,
                top: 0,
                child: Container(
                    width: 390,
                    height: 534,
                    decoration: const ShapeDecoration(
                        color: Color(0xFF212326),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                            ),
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 16,
                top: 185,
                child: Container(
                    width: 359,
                    height: 225,
                    decoration: const ShapeDecoration(
                        color: Color(0xFF0C0C0C),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                            ),
                        ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      
                      child: ListView.separated(
                        padding: EdgeInsets.only(left: 16, right: 16),
                          separatorBuilder: (context, index) {
                              return const SizedBox(
                                  width: 8,
                                  height: 1,
                              );
                          },
                          itemCount: excerciseWorkoutConfig.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                              return ExerciseInfoCard(name: excerciseWorkoutConfig[index].name, sets: "1", duration: excerciseWorkoutConfig[index].duration.toString(), imageUrl: '',);
                          },
                      ),
                    ),
                ),
            ),
            Positioned(
                left: 37,
                top: 61,
                child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                    ),
                ),
            ),
            Positioned(
                left: 161,
                top: 25,
                child: Container(
                    width: 67,
                    height: 6,
                    decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 16,
                top: 134,
                child: Container(
                    width: 359,
                    height: 51,
                    child: Stack(
                        children: [
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                    width: 359,
                                    height: 51,
                                    decoration: const ShapeDecoration(
                                        color: Color(0xFF212326),
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(width: 1, color: Color(0xFF161719)),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                            ),
                                        ),
                                        shadows: [
                                            BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(0, 4),
                                                spreadRadius: 0,
                                            )
                                        ],
                                    ),
                                ),
                            ),
                            const Positioned(
                                left: 29,
                                top: 12,
                                child: Row(
                                  children: [
                                    Icon(Icons.menu_book, color: Colors.white, size: 24,),
                                    SizedBox(width: 8,),
                                    Text(
                                        'Übungen',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                        ),
                                    ),
                                  ],
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        ],
    ),
);
      },
    );
  }

  static void show({
    required BuildContext context,
    required List<WorkoutPlanConfig> items,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFF262424),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(items[index].name.toString()),
                onTap: () {
                  Navigator.pop(context, items[index]);
                },
              );
            },
          ),
        );
      },
    );
  }
}
