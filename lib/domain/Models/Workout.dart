import 'package:exopek_workout_app/domain/Models/Exercise.dart';

enum PhaseType {
  phase1,
  phase2,
  phase3,
  phase4,
  phase5,
  phase6,
  phase7,
  phase8,
}

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
  final int? comments;
  final int? likes;

  WorkoutListItem(
      {required this.id,
      required this.name,
      required this.previewImageUrl,
      required this.hashtags,
      required this.duration,
      this.comments,
      this.likes})
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
    final comments = json['comments'] as int;
    final likes = json['likes'] as int;

    return WorkoutListItem(
      id: id,
      name: name,
      previewImageUrl: previewImageUrl,
      hashtags: hashtags,
      duration: duration,
      comments: comments,
      likes: likes,
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
  final String description;

  WorkoutDetails({
    required this.id,
    required this.name,
    required this.previewImageUrl,
    required this.muscleImageUrl,
    required this.hashtags,
    required this.exercises,
    required this.exerciseMap,
    required this.currentStageTypes,
    required this.description,
  }) : super(
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
    final description = json['description'] as String;

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
        currentStageTypes: currentStageTypes,
        description: description);
  }

  get sortedExercises => exercises
    ..sort((a, b) => a.stageType.compareTo(b.stageType))
    ..sort((a, b) => a.stageOrder.compareTo(b.stageOrder));

  get sortedCurrentStageTypes =>
      currentStageTypes..sort((a, b) => a.compareTo(b));
}

class WorkoutPlanConfig extends Workout {
  final String id;
  final String name;
  final String previewImageUrl;
  final int phaseType;
  final int order;
  final String planWorkoutId;

  WorkoutPlanConfig({
    required this.id,
    required this.name,
    required this.previewImageUrl,
    required this.phaseType,
    required this.order,
    required this.planWorkoutId,
  }) : super(
            id: id, name: name, previewImageUrl: previewImageUrl, hashtags: '');

  // FromReadDto
  factory WorkoutPlanConfig.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final name = json['name'] as String;
    final previewImageUrl = json['previewImageUrl'] as String;
    final phaseType = json['phaseType'] as int;
    final order = json['order'] as int;
    final planWorkoutId = json['planWorkoutId'] as String;

    return WorkoutPlanConfig(
      id: id,
      name: name,
      previewImageUrl: previewImageUrl,
      phaseType: phaseType,
      order: order,
      planWorkoutId: planWorkoutId,
    );
  }
  get phaseTypeAsType => StageType.values[phaseType];

  get phaseTypeAsString {
    switch (phaseType) {
      case 0:
        return 'Phase 1';
      case 1:
        return 'Phase 2';
      case 2:
        return 'Phase 3';
      case 3:
        return 'Phase 4';
      default:
        return 'Phase 1';
    }
  }
}
