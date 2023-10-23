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