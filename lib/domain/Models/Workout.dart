import 'package:exopek_workout_app/domain/Models/Exercise.dart';

sealed class Workout {
  final String id;
  final String name;
  final String previewImageUrl;
  final String hashtags;

  Workout(
      {required this.id,
      required this.name,
      required this.previewImageUrl,
      required this.hashtags});

  get hashtagsList => hashtags.split(',') as List<String>;

  get hashtagsStringWithHash =>
      hashtagsList.map((e) => '#$e').join(' ') as String;
}

class WorkoutListItem extends Workout {
  final String id;
  final String name;
  final String previewImageUrl;
  final String hashtags;
  final int duration;

  WorkoutListItem(
      {required this.id,
      required this.name,
      required this.previewImageUrl,
      required this.hashtags,
      required this.duration})
      : super(
            id: id,
            name: name,
            previewImageUrl: previewImageUrl,
            hashtags: hashtags);

  // FromReadDto
  factory WorkoutListItem.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final name = json['name'] as String;
    final previewImageUrl = json['previewImageUrl'] as String;
    final hashtags = json['hashtags'] as String;
    final duration = json['duration'] as int;

    return WorkoutListItem(
      id: id,
      name: name,
      previewImageUrl: previewImageUrl,
      hashtags: hashtags,
      duration: duration,
    );
  }

  get durationString => '$duration m';
}

class WorkoutDetails extends Workout {
  final String id;
  final String name;
  final String previewImageUrl;
  final String muscleImageUrl;
  final String hashtags;
  final List<ExcerciseWorkoutConfig> exercises;
  final Map<int, List<ExcerciseWorkoutConfig>> exerciseMap;
  final List<int> currentStageTypes;

  WorkoutDetails(
      {required this.id,
      required this.name,
      required this.previewImageUrl,
      required this.muscleImageUrl,
      required this.hashtags,
      required this.exercises,
      required this.exerciseMap,
      required this.currentStageTypes})
      : super(
            id: id,
            name: name,
            previewImageUrl: previewImageUrl,
            hashtags: hashtags);

  // FromReadDto
  factory WorkoutDetails.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final name = json['name'] as String;
    final previewImageUrl = json['previewImageUrl'] as String;
    final muscleImageUrl = json['muscleImageUrl'] as String;
    final hashtags = json['hashtags'] as String;
    final exercises = json['exercises'] as List<dynamic>?;

    final exercisesList = exercises != null
        ? exercises
            .map((e) =>
                ExcerciseWorkoutConfig.fromJson(e as Map<String, dynamic>))
            .toList()
        : <ExcerciseWorkoutConfig>[];

    final currentStageTypes =
        exercisesList.map((e) => e.stageType).toSet().toList() as List<int>;

    final exerciseMap = <int, List<ExcerciseWorkoutConfig>>{};

    exercisesList.forEach((exercise) {
      if (!exerciseMap.containsKey(exercise.stageType)) {
        exerciseMap[exercise.stageType] = <ExcerciseWorkoutConfig>[];
      }
      exerciseMap[exercise.stageType]!.add(exercise);
    });

    return WorkoutDetails(
        id: id,
        name: name,
        previewImageUrl: previewImageUrl,
        muscleImageUrl: muscleImageUrl,
        hashtags: hashtags,
        exercises: exercisesList,
        exerciseMap: exerciseMap,
        currentStageTypes: currentStageTypes);
  }

  get sortedExercises =>
      exercises..sort((a, b) => a.stageType.compareTo(b.stageType));

  get sortedCurrentStageTypes =>
      currentStageTypes..sort((a, b) => a.compareTo(b));
}
