import 'dart:io';

import 'package:exopek_workout_app/domain/Models/User.dart';

abstract class IUserRepository {
  Future<ReadUserDto> getUser();
  Future<bool> updateUser(UpdateUserDto user);
  Future<bool> createUser(CreateUserDto user);
  Future<bool> deleteUser();
  Future<String> login(String email, String password);
  Future<bool> uploadProfilImage(File image);
  Future<bool> resetPassword(String email);
  Future<bool> checkUserIsLogedIn();
  Future<bool> logout();
}