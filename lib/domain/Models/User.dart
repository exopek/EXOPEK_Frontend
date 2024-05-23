import 'package:exopek_workout_app/domain/Models/Enums/SportType.dart';
import 'package:exopek_workout_app/domain/Models/Enums/TrainingFrequencyType.dart';

enum GenderType {
  Male,
  Female,
  Diverse
}

sealed class User {
  
  User({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    this.roles,
    required this.email,
    required this.password,
    this.imageUrl,
    required this.sport,
    this.height,
    this.weight,
    this.age,
    this.previousTrainingFrequency,
    this.trainingFrequency,
  });

  final String? id;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final String password;
  final List<String>? roles;
  final String? imageUrl;
  final SportType sport;
  final double? height;
  final double? weight;
  final int? age;
  final TrainingFrequencyType? previousTrainingFrequency;
  final TrainingFrequencyType? trainingFrequency;

  //get trainingFrequencyType => TrainingFrequencyType.values[trainingFrequency ?? 0];

  get trainingFrequencyTypeAsString {
    switch (trainingFrequency) {
      case 0:
        return '0 - 1 Unregelmäßig';
      case 1:
        return '2 - 3 Regelmäßig';
      case 2:
        return '4 - 5 Athlet';
      case 3:
        return '6 - 7 Profi Athlet';
      default:
        return '0 - 1 Unregelmäßig';
    }
  }
}

class CreateUserDto extends User {

  CreateUserDto({
    required String firstname,
    required String lastname,
    required String username,
    required String email,
    required String password,
    List<String>? roles,})
      : super(
          firstname: firstname,
          lastname: lastname,
          username: username,
          email: email,
          password: password,
          roles: roles,
          sport: SportType.None,
        );
    factory CreateUserDto.fromJson(Map<String, dynamic> json) => CreateUserDto(
        firstname: json["firstname"] as String,
        lastname: json["lastname"] as String,
        username: json["username"] as String,
        email: json["email"] as String,
        password: json["password"] as String,
        roles: json["roles"] as List<String>,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "password": password,
        "roles": roles,
      };
        
}

class ReadUserDto extends User {
  double? height;
  double? weight;
  int? age;
  SportType sport;
  TrainingFrequencyType? previousTrainingFrequency;
  TrainingFrequencyType? trainingFrequency;
  ReadUserDto({
    required String id,
    required String firstname,
    required String lastname,
    required String email,
    final String? username,
    final String? imageUrl,
    this.height,
    this.weight,
    this.age,
    required this.sport,
    this.previousTrainingFrequency,
    this.trainingFrequency,
    List<String>? roles,})
      : super(
          id: id,
          firstname: firstname,
          lastname: lastname,
          email: email,
          roles: [],
          username: username ?? '',
          password: '',
          imageUrl: imageUrl,
          age: age,
          height: height,
          weight: weight,
          sport: sport,
          previousTrainingFrequency: previousTrainingFrequency,
          trainingFrequency: trainingFrequency,
        );
    factory ReadUserDto.fromJson(Map<String, dynamic> json) => ReadUserDto(
        id: json["id"] as String,
        firstname: json["firstName"] as String,
        lastname: json["lastName"] as String,
        email: json["email"] as String,
        username: json["userName"] as String,
        imageUrl: json["imageUrl"] as String?,
        height: double.tryParse(json["height"].toString()),
        weight: double.tryParse(json["weight"].toString()),
        age: json["age"] as int?,
        sport: SportType.values[json["sportType"] as int],
        previousTrainingFrequency: TrainingFrequencyType.values[json["previousTrainingFrequency"] as int],
        trainingFrequency: TrainingFrequencyType.values[json["trainingFrequency"] as int],
      );   
}

class UpdateUserDto extends User {
  String? phonenumber;
  int? age;
  double? height;
  double? weight;
  SportType sport;
  TrainingFrequencyType? previousTrainingFrequency;
  TrainingFrequencyType? trainingFrequency = TrainingFrequencyType.None;
  String? imageUrl;

  UpdateUserDto({
    required String? id,
    required String firstname,
    required String lastname,
    required String username,
    required String email,
    required String password,
    List<String>? roles,
    this.phonenumber,
    this.age,
    this.height,
    this.weight,
    required this.sport,
    this.previousTrainingFrequency,
    this.trainingFrequency,
    this.imageUrl})
      : super(
          id: id,
          firstname: firstname,
          lastname: lastname,
          username: username,
          email: email,
          password: password,
          roles: roles,
          imageUrl: imageUrl,
          sport: sport,
        );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "phonenumber": phonenumber,
        "email": email,
        "password": password,
        "age": age,
        "height": height,
        "weight": weight,
        "sportType": sport.index,
        "previousTrainingFrequency": previousTrainingFrequency!.index,
        "trainingFrequency": trainingFrequency!.index,
        "imageUrl": imageUrl,
      };

  UpdateUserDto copyWith({  
    String? id,
    String? firstname,
    String? lastname,
    String? username,
    String? email,
    String? password,
    List<String>? roles,
    String? phonenumber,
    int? age,
    double? height,
    double? weight,
    SportType? sport,
    TrainingFrequencyType? previousTrainingFrequency,
    TrainingFrequencyType? trainingFrequency,
    String? imageUrl,
  }) {
    return UpdateUserDto(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      roles: roles ?? this.roles,
      phonenumber: phonenumber ?? this.phonenumber,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      sport: sport ?? this.sport,
      previousTrainingFrequency: previousTrainingFrequency ?? this.previousTrainingFrequency,
      trainingFrequency: trainingFrequency ?? this.trainingFrequency,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
        
}