import 'package:exopek_workout_app/domain/Models/Enums/DifficultyType.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:flutter/material.dart';

enum StatusType {
  NONE,
  ACTIVE,
  INACTIVE,
  DELETED,
  COMPLETED,
  PENDING,
  REJECTED,
  APPROVED,
  BLOCKED,
  VERIFIED,
}

sealed class Plan {
  final String id;
  final String name;
  final String previewImageUrl;
  final String hashtags;

  Plan(
      {required this.id,
      required this.name,
      required this.previewImageUrl,
      required this.hashtags});

  get hashtagsList => hashtags.split(',') as List<String>;

  get hashtagsStringWithHash =>
      hashtagsList.map((e) => '#$e').join(' ') as String;
}

class PlanListItem extends Plan {
  final String id;
  final String name;
  final String previewImageUrl;
  final String hashtags;
  final int duration;
  final String videoUrl;
  final String? description;

  PlanListItem(
      {required this.id,
      required this.name,
      required this.previewImageUrl,
      required this.hashtags,
      required this.duration,
      required this.videoUrl,
      this.description})
      : super(
            id: id,
            name: name,
            previewImageUrl: previewImageUrl,
            hashtags: hashtags);

  // FromReadDto
  factory PlanListItem.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final name = json['name'] as String;
    final previewImageUrl = json['previewImageUrl'] as String;
    final hashtags = json['hashtags'] as String;
    final duration = json['duration'] as int;
    final videoUrl = json['videoUrl'] as String;
    final description = json['description'] as String?;

    return PlanListItem(
      id: id,
      name: name,
      previewImageUrl: previewImageUrl,
      hashtags: hashtags,
      duration: duration,
      videoUrl: videoUrl,
      description: description,
    );
  }

  get durationString => '$duration m';
}

// View-Model
class PlanDetails extends Plan {
  final String id;
  final String name;
  final String previewImageUrl;
  final String hashtags;
  final int duration;
  final String description;
  final List<WorkoutPlanConfig> workouts;
  final Map<int, List<WorkoutPlanConfig>> workoutMap;
  final List<int> currentPhaseTypes;
  final List<String> uiPlanPromises;
  final List<DifficultyType>? difficultyTypes;
  final DifficultyType difficultyType;

  PlanDetails(
      {required this.id,
      required this.name,
      required this.previewImageUrl,
      required this.hashtags,
      required this.duration,
      required this.workouts,
      required this.workoutMap,
      required this.currentPhaseTypes,
      required this.uiPlanPromises,
      required this.description,
      required this.difficultyType,
      this.difficultyTypes})
      : super(
            id: id,
            name: name,
            previewImageUrl: previewImageUrl,
            hashtags: hashtags);

  // FromReadDto
  factory PlanDetails.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final name = json['name'] as String;
    final previewImageUrl = json['previewImageUrl'] as String;
    final hashtags = json['hashtags'] as String;
    final duration = json['duration'] as int;
    final description = json['description'] as String;
    final uiPlanPromises = json['uiPlanPromises'] as List<dynamic>;
    final workouts = (json['workouts'] as List<dynamic>)
        .map((e) => WorkoutPlanConfig.fromJson(e as Map<String, dynamic>))
        .toList();
    final difficultyTypes = (json['possibleDifficultyTypes']);
    final difficultyType = json['difficulty'] as int;

    final currentPhaseTypes =
        workouts.map((e) => e.phaseType).toSet().toList() as List<int>;

    final workoutsMap = <int, List<WorkoutPlanConfig>>{};

    workouts.forEach((workout) {
      if (!workoutsMap.containsKey(workout.phaseType)) {
        workoutsMap[workout.phaseType] = <WorkoutPlanConfig>[];
      }
      workoutsMap[workout.phaseType]!.add(workout);
    });

    return PlanDetails(
      id: id,
      name: name,
      previewImageUrl: previewImageUrl,
      hashtags: hashtags,
      duration: duration,
      workouts: workouts,
      description: description,
      workoutMap: workoutsMap,
      currentPhaseTypes: currentPhaseTypes,
      uiPlanPromises: uiPlanPromises.map((e) => e as String).toList(),
      difficultyType: DifficultyType.values[difficultyType],
      difficultyTypes: difficultyTypes is List
          ? difficultyTypes
              .map((e) => DifficultyType.values[e as int])
              .toList()
          : [],
    );
  }

  get durationString => '$duration m';

  get sortedWorkouts =>
      workouts..sort((a, b) => a.phaseType.compareTo(b.phaseType));

  List<int> get sortedCurrentPhaseTypes =>
      currentPhaseTypes..sort((a, b) => a.compareTo(b));

  List<PhaseType> get sortedCurrentPhaseTypesAsType {
    final phaseTypes = <PhaseType>[];
    for (final phaseType in sortedCurrentPhaseTypes) {
      switch (phaseType) {
        case 0:
          phaseTypes.add(PhaseType.phase1);
          break;
        case 1:
          phaseTypes.add(PhaseType.phase2);
          break;
        case 2:
          phaseTypes.add(PhaseType.phase3);
          break;
        case 3:
          phaseTypes.add(PhaseType.phase4);
          break;
        default:
          break;
      }
    }
    return phaseTypes;
  }
}

class PlanStatus {
  final String id;
  final int currentPhase;
  final int status;
  final List<String> workoutIds;
  final int progressPercentage;
  final String planId;
  final String createdAt;
  final DifficultyType? difficultyType;

  PlanStatus(
      {required this.id,
      required this.currentPhase,
      required this.status,
      required this.workoutIds,
      required this.progressPercentage,
      required this.planId,
      required this.createdAt,
      this.difficultyType});

  // FromReadDto
  factory PlanStatus.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final status = json['status'] as int;
    final currentPhase = json['currentPhase'] as int;
    final workoutIds = (json['workoutIds'] as List<dynamic>);
    final progressPercentage = json['progressPercentage'] as int;
    final planId = json['planId'] as String;
    final createdAt = json['createdAt'] as String;
    final difficultyType = json['difficultyType'] as int;

    return PlanStatus(
      id: id,
      status: status,
      currentPhase: currentPhase,
      workoutIds: workoutIds.map((e) => e as String).toList(),
      progressPercentage: progressPercentage,
      planId: planId,
      createdAt: createdAt,
      difficultyType: DifficultyType.values[difficultyType],
    );
  }

  factory PlanStatus.empty() {
    return PlanStatus(
      id: '',
      status: 0,
      currentPhase: 0,
      workoutIds: [],
      progressPercentage: 0,
      planId: '',
      createdAt: DateTime.now().toString(),
      difficultyType: DifficultyType.beginner,
    );
  }

  PhaseType get phaseTypeAsType {
    switch (currentPhase) {
      case 0:
        return PhaseType.phase1;
      case 1:
        return PhaseType.phase2;
      case 2:
        return PhaseType.phase3;
      case 3:
        return PhaseType.phase4;
      default:
        return PhaseType.phase1;
    }
  }

  String get phaseTypeAsString {
    switch (currentPhase) {
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

  StatusType get statusTypeAsType {
    if (status == 0) {
      return StatusType.INACTIVE;
    }
    if (status == 1) {
      return StatusType.ACTIVE;
    }
    return StatusType.INACTIVE;
  }

  String get statusTypeAsString {
    switch (status) {
      case 0:
        return 'Keinen Status';
      case 1:
        return 'Active';
      case 2:
        return 'Inactive';
      case 3:
        return 'Deleted';
      case 4:
        return 'Completed';
      default:
        return 'Keinen Status';
    }
  }
}

class PlanDetailsViewModel {
  final PlanDetails plan;
  final PlanStatus planStatus;

  PlanDetailsViewModel({required this.plan, required this.planStatus});

  get sortedWorkouts =>
      plan.workouts..sort((a, b) => a.phaseType.compareTo(b.phaseType));

  get sortedCurrentPhaseTypes =>
      plan.currentPhaseTypes..sort((a, b) => a.compareTo(b));
}

class PlanPhaseViewModel extends Plan {
  final PlanDetails plan;
  final List<WorkoutPlanConfig> workouts; // sorted by phaseType
  final PlanStatus? planStatus;

  PlanPhaseViewModel(
      {required this.workouts, required this.plan, required this.planStatus})
      : super(
            id: plan.id,
            name: plan.name,
            previewImageUrl: plan.previewImageUrl,
            hashtags: plan.hashtags);

  get completedWorkoutsCounter => workouts
      .where(
          (element) => planStatus!.workoutIds.contains(element.planWorkoutId))
      .length;
}
