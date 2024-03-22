sealed class Like {
  final String workoutId;

  Like({
    required this.workoutId,
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

  LikeReadDto({
    required this.workoutId,
    this.id,
  }) : super(
          workoutId: workoutId,
        );

  factory LikeReadDto.fromJson(Map<String, dynamic> json) {
    final workoutId = json['workoutId'] as String;
    final id = json['id'] as String;

    return LikeReadDto(
      workoutId: workoutId,
      id: id,
    );
  }
}
