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
    this.imageUrl,
  });

  final String? id;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final String password;
  final List<String>? roles;
  final String? imageUrl;
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
    required String id,
    required String firstname,
    required String lastname,
    required String email,
    final String? username,
    final String? imageUrl,
    List<String>? roles,})
      : super(
          id: id,
          firstname: firstname,
          lastname: lastname,
          email: email,
          roles: [],
          username: username ?? '',
          password: ''

        );
    factory ReadUserDto.fromJson(Map<String, dynamic> json) => ReadUserDto(
        id: json["id"] as String,
        firstname: json["firstName"] as String,
        lastname: json["lastName"] as String,
        email: json["email"] as String,
        username: json["userName"] as String,
        imageUrl: json["imageUrl"] as String?,
      );   
}

class UpdateUserDto extends User {
  String? phonenumber;
  int? age;
  double? height;
  double? weight;
  int? sport;
  int? previousTrainingFrequency;
  int? trainingFrequency;

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
    this.sport,
    this.previousTrainingFrequency,
    this.trainingFrequency,})
      : super(
          id: id,
          firstname: firstname,
          lastname: lastname,
          username: username,
          email: email,
          password: password,
          roles: roles,
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
        "sport": sport,
        "previousTrainingFrequency": previousTrainingFrequency,
        "trainingFrequency": trainingFrequency,
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
    int? sport,
    int? previousTrainingFrequency,
    int? trainingFrequency,
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
    );
  }
        
}