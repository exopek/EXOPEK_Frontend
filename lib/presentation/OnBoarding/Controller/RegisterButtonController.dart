import 'dart:async';

import 'package:dio/dio.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/data/repository/UserRepository.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterButtonController extends AutoDisposeAsyncNotifier<void> {
  RegisterButtonController();

  void register({required String username, required String password, required String email, required String lastname, required String firstname}) async {
    final UserRepository userRepository = ref.read(userRepositoryProvider);
    final Dio _dio = ref.read(dioProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => userRepository.createUser(CreateUserDto(username: username, password: password, email: email, lastname: lastname, firstname: firstname, roles: ["user"])));
    if (state is AsyncError) {
      state = AsyncError('Failure to register!', StackTrace.current);
    }
    state = await AsyncValue.guard(
        () => userRepository.login(username, password));
    if (state is AsyncError) {
      state = AsyncError("Plan could not be fetched", StackTrace.current);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (state is AsyncData) {
      prefs.setString('jwt_token', (state as AsyncData).value.toString());
      prefs.setString('username', username);
      prefs.setString('password', password);
      _dio.options.headers["Authorization"] =
          "Bearer ${prefs.getString('jwt_token')}";
    }
    if (state is AsyncError) {
       state = AsyncError('Failure to login!', StackTrace.current);
    }
  }
  
  @override
  FutureOr<void> build() {
  }

}