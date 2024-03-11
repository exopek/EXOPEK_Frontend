enum GenderType {
  Male,
  Female,
  Diverse
}

enum TrainingFrequencyType {
  None,
  Once,
  Twice,
  ThreeTimes,
  FourTimes,
  FiveTimes,
  SixTimes,
  SevenTimes
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
  });

  final String? id;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final String password;
  final List<String>? roles;
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

  ReadUserDto({
    required String firstname,
    required String lastname,
    required String email,
    List<String>? roles,})
      : super(
          firstname: firstname,
          lastname: lastname,
          email: email,
          roles: [],
          username: '',
          password: ''

        );
    factory ReadUserDto.fromJson(Map<String, dynamic> json) => ReadUserDto(
        firstname: json["firstName"] as String,
        lastname: json["lastName"] as String,
        email: json["email"] as String,
      );   
}

class UpdateUserDto extends User {
  final String? phonenumber;
  final int? age;
  final double? height;
  final double? weight;
  final String? sport;
  final TrainingFrequencyType? previousTrainingFrequency;
  final TrainingFrequencyType? trainingFrequency;

  UpdateUserDto({
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
    this.sport,
    this.previousTrainingFrequency,
    this.trainingFrequency,})
      : super(
          firstname: firstname,
          lastname: lastname,
          username: username,
          email: email,
          password: password,
          roles: roles,
        );
    factory UpdateUserDto.fromJson(Map<String, dynamic> json) => UpdateUserDto(
        firstname: json["firstname"] as String,
        lastname: json["lastname"] as String,
        username: json["username"] as String,
        phonenumber: json["phonenumber"] as String?,
        email: json["email"] as String,
        password: json["password"] as String,
        roles: json["roles"] as List<String>,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "phonenumber": phonenumber,
        "email": email,
        "password": password,
        "roles": roles,
        "age": age,
        "height": height,
        "weight": weight,
        "sport": sport,
        "previousTrainingFrequency": previousTrainingFrequency,
        "trainingFrequency": trainingFrequency,
      };
        
}