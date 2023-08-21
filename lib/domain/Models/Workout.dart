class Workout {
  final String id;
  final String name;
  final String previewImageUrl;

  Workout(
      {required this.id, required this.name, required this.previewImageUrl});

  // FromReadDto
  factory Workout.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final previewImageUrl = json['previewImageUrl'];

    return Workout(
      id: id,
      name: name,
      previewImageUrl: previewImageUrl,
    );
  }
}
