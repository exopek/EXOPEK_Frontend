import 'package:exopek_workout_app/domain/Models/Workout.dart';

sealed class Like {
  final String workoutId;
  final WorkoutListItem? workout;

  Like({
    required this.workoutId,
    this.workout,
  });
}

class LikeCreateDto extends Like {
  final String workoutId;

  LikeCreateDto({
    required this.workoutId,
  }) : super(
          workoutId: workoutId,
        );
}

class LikeReadDto extends Like {
  final String workoutId;
  final String? id;
  final WorkoutListItem? workout;

  LikeReadDto({
    required this.workoutId,
    this.id,
    this.workout,
  }) : super(
          workoutId: workoutId,
          workout: workout,
        );

  factory LikeReadDto.fromJson(Map<String, dynamic> json) {
    final workoutId = json['workoutId'] as String;
    final id = json['id'] as String;
    final workout = json['workout'] != null
        ? WorkoutListItem.fromJson(json['workout'] as Map<String, dynamic>)
        : null;

    return LikeReadDto(
      workoutId: workoutId,
      id: id,
      workout: workout,
    );
  }
}
