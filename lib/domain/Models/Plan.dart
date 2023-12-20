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

  PlanListItem(
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
  factory PlanListItem.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final name = json['name'] as String;
    final previewImageUrl = json['previewImageUrl'] as String;
    final hashtags = json['hashtags'] as String;
    final duration = json['duration'] as int;

    return PlanListItem(
      id: id,
      name: name,
      previewImageUrl: previewImageUrl,
      hashtags: hashtags,
      duration: duration,
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

  PlanDetails(
      {required this.id,
      required this.name,
      required this.previewImageUrl,
      required this.hashtags,
      required this.duration,
      required this.workouts,
      required this.workoutMap,
      required this.currentPhaseTypes,
      required this.description})
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
    final workouts = (json['workouts'] as List<dynamic>)
        .map((e) => WorkoutPlanConfig.fromJson(e as Map<String, dynamic>))
        .toList();

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
    );
  }

  get durationString => '$duration m';

  get sortedWorkouts =>
      workouts..sort((a, b) => a.phaseType.compareTo(b.phaseType));

  get sortedCurrentPhaseTypes =>
      currentPhaseTypes..sort((a, b) => a.compareTo(b));
}

class PlanStatus {
  final String id;
  final int currentPhase;
  final int status;
  final List<String> workoutIds;

  PlanStatus(
      {required this.id,
      required this.currentPhase,
      required this.status,
      required this.workoutIds});

  // FromReadDto
  factory PlanStatus.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final status = json['status'] as int;
    final currentPhase = json['currentPhase'] as int;
    final workoutIds = (json['workoutIds'] as List<dynamic>);

    return PlanStatus(
      id: id,
      status: status,
      currentPhase: currentPhase,
      workoutIds: workoutIds.map((e) => e as String).toList(),
    );
  }

  factory PlanStatus.empty() {
    return PlanStatus(
      id: '',
      status: 0,
      currentPhase: 0,
      workoutIds: [],
    );
  }

  get phaseTypeAsType => PhaseType.values[currentPhase];

  get phaseTypeAsString {
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

  get statusTypeAsType => StatusType.values[status];

  get statusTypeAsString {
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

class PlanPhase extends Plan {
  final PlanDetails plan;
  final List<WorkoutPlanConfig> workouts; // sorted by phaseType
  final PlanStatus? planStatus;

  PlanPhase(
      {required this.workouts, required this.plan, required this.planStatus})
      : super(
            id: plan.id,
            name: plan.name,
            previewImageUrl: plan.previewImageUrl,
            hashtags: plan.hashtags);

  get completedWorkoutsCounter => workouts
      .where((element) => planStatus!.workoutIds.contains(element.id))
      .length;
}
