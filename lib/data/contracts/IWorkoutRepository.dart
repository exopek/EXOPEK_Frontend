import 'package:exopek_workout_app/domain/Models/workout.dart';

abstract class IWorkoutRepository {
  Future<List<dynamic>> getWorkouts({Map<String, String>? query});

  Future<dynamic> getWorkout({Map<String, String>? query});
  Future<bool> completeWorkout({required String workoutId});
  Future<List<dynamic>> getWorkoutComments(String id);
  Future<dynamic> addWorkoutComment({required String workoutId, required String comment, required int rating});
  Future<dynamic> likeWorkout({required String workoutId}); 
  Future<List<dynamic>> getWorkoutLikes();
  Future<dynamic> deleteWorkoutLike({required String workoutLikeId});
  Future<List<dynamic>> getWorkoutCompletes();
  /* Future<Workout> getWorkout(String id);
  Future<Workout> addWorkout(Workout workout);
  Future<Workout> updateWorkout(Workout workout);
  Future<void> deleteWorkout(String id); */
}
