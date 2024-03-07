import 'package:exopek_workout_app/domain/Models/User.dart';

abstract class IUserRepository {
  Future<User> getUser(String id);
  Future<User> updateUser(User user);
  Future<User> createUser(User user);
  Future<User> deleteUser(String id);
  Future<String> login(String email, String password);
}