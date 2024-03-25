import 'package:exopek_workout_app/domain/Models/User.dart';

sealed class Comment {
  final String? id;
  final String? comment;
  final String? createdAt;
  final String? userName;
  final String? firstName;
  final String? lastName;

  Comment(
      {this.id,
      this.comment,
      this.createdAt,
      this.userName,
      this.firstName,
      this.lastName,
      });
}

class CommentReadDto extends Comment {
  final String? id;
  final String? comment;
  final String? createdAt;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final ReadUserDto? user;

  CommentReadDto(
      {required this.id,
      required this.comment,
      required this.createdAt,
      required this.userName,
      required this.firstName,
      required this.lastName,
      this.user})
      : super(
            id: id,
            comment: comment,
            createdAt: createdAt,
            userName: userName,
            firstName: firstName,
            lastName: lastName);

  factory CommentReadDto.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final comment = json['comment'] as String;
    final createdAt = json['createdAt'] as String;
    final user = ReadUserDto.fromJson(json['user'] as Map<String, dynamic>);

    return CommentReadDto(
      id: id,
      comment: comment,
      createdAt: createdAt,
      userName: user.username,
      firstName: user.firstname,
      lastName: user.lastname,
    );
  }
}

class CommentCreateDto extends Comment {
  final String? workoutId;
  final String? comment;

  CommentCreateDto(
      {required this.workoutId,
      required this.comment,})
      : super(
            comment: comment,);
}