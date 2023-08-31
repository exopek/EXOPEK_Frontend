import 'package:exopek_workout_app/domain/Models/workout.dart';

abstract class IWorkoutRepository {
  Future<List<dynamic>> getWorkouts();

  Future<dynamic> getWorkout(String id);
  /* Future<Workout> getWorkout(String id);
  Future<Workout> addWorkout(Workout workout);
  Future<Workout> updateWorkout(Workout workout);
  Future<void> deleteWorkout(String id); */
}
