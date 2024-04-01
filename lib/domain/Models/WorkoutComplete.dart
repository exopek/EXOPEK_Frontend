import 'package:exopek_workout_app/domain/Models/Workout.dart';

class WorkoutCompleteReadDto {
  final DateTime createdAt;
  final WorkoutListItem workout;

  WorkoutCompleteReadDto(
      {required this.createdAt,
      required this.workout});

  factory WorkoutCompleteReadDto.fromJson(Map<String, dynamic> json) {
    final createdAt = DateTime.parse(json['createdAt'] as String);
    final workout = WorkoutListItem.fromJson(json['workout'] as Map<String, dynamic>);

    return WorkoutCompleteReadDto(
      createdAt: createdAt,
      workout: workout,
    );
  }
}