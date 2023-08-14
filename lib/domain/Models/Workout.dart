class Workout {
  final String id;
  final String name;
  final String description;
  final String previewImage;

  Workout(
      {required this.id,
      required this.name,
      required this.description,
      required this.previewImage});

  // FromReadDto
  factory Workout.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final description = json['description'];
    final previewImage = json['previewImage'];

    return Workout(
      id: id,
      name: name,
      description: description,
      previewImage: previewImage,
    );
  }
}
