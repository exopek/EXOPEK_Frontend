enum StageType { warmup, workout, cooldown }

sealed class Excercise {
  final String id;
  final String name;
  final String previewImageUrl;

  Excercise({
    required this.id,
    required this.name,
    required this.previewImageUrl,
  });
}

class ExcerciseWorkoutConfig extends Excercise {
  final String id;
  final String name;
  final String previewImageUrl;
  final int duration;
  final String videoUrl;
  final int reps;
  final int stageOrder;
  final int stageRound;
  final int stageType;
  final bool isRest;

  ExcerciseWorkoutConfig(
      {required this.id,
      required this.name,
      required this.previewImageUrl,
      required this.duration,
      required this.videoUrl,
      required this.reps,
      required this.stageOrder,
      required this.stageRound,
      required this.stageType,
      required this.isRest})
      : super(
          id: id,
          name: name,
          previewImageUrl: previewImageUrl,
        );

  // FromReadDto
  factory ExcerciseWorkoutConfig.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final name = json['name'] as String;
    final previewImageUrl = json['previewImageUrl'] as String;
    final duration = json['duration'] as int;
    final videoUrl = json['videoUrl'] as String;
    final reps = json['reps'] as int;
    final stageOrder = json['stageOrder'] as int;
    final stageRound = json['stageRound'] as int;
    final stageType = json['stageType'] as int;
    final isRest = json['isRest'] as bool;

    return ExcerciseWorkoutConfig(
      id: id,
      name: name,
      previewImageUrl: previewImageUrl,
      duration: duration,
      videoUrl: videoUrl,
      reps: reps,
      stageOrder: stageOrder,
      stageRound: stageRound,
      stageType: stageType,
      isRest: isRest,
    );
  }

  get stageTypeAsType => StageType.values[stageType];

  get stageTypeAsString {
    switch (stageType) {
      case 0:
        return 'Warmup';
      case 1:                             
        return 'Workout';
      case 2:
        return 'Cooldown';
      default:
        return 'Unknown';
    }
  }

  get durationString => '$duration m';
}
