

class Workout {
  final String id;
  final String name;
  final String description;

  Workout(this.id, this.name, this.description);

  Workout.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'];
  
}