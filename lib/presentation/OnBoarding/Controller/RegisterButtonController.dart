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

  void register(
      {required String username,
      required String password,
      required String email,
      required String lastname,
      required String firstname,
      bool? marketingConfirmed,
      bool? privacyPolicyConfirmed
      }) async {
    final UserRepository userRepository = ref.read(userRepositoryProvider);
    final Dio _dio = ref.read(dioProvider);
    state = const AsyncLoading();
    try {
      await userRepository.createUser(CreateUserDto(
          username: username,
          password: password,
          email: email,
          lastname: lastname,
          firstname: firstname,
          roles: ["user"],
          marketingConfirmed: marketingConfirmed,
          privacyPolicyConfirmed: privacyPolicyConfirmed));
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.data != null) {
          state =
              AsyncError(e.response!.data[0].toString(), StackTrace.current);
        } else {
          state = AsyncError(e.message.toString(), StackTrace.current);
        }
      } else {
        state = AsyncError(e.toString(), StackTrace.current);
      }
    }
    String jwtToken = "";
    if (state is! AsyncError) {
      try {
        jwtToken = await userRepository.login(username, password);
        state = const AsyncValue.data(null);
      } catch (e) {
        if (e is DioException) {
          if (e.response != null && e.response!.data != null) {
            state =
                AsyncError(e.response!.data[0].toString(), StackTrace.current);
          } else {
            state = AsyncError(e.message.toString(), StackTrace.current);
          }
        } else {
          state = AsyncError(e.toString(), StackTrace.current);
        }
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (state is AsyncData) {
      prefs.setString('jwt_token', jwtToken);
      prefs.setString('username', username);
      prefs.setString('password', password);
      _dio.options.headers["Authorization"] =
          "Bearer ${prefs.getString('jwt_token')}";
    }

    // Fetch fresh User
    if (state is AsyncData) {
      final user = await AsyncValue.guard(() => userRepository.getUser());
      if (user is AsyncError) {
        state = AsyncError("User could not be fetched", StackTrace.current);
      }
      // Set the user state
      ref.read(userStateProvider.notifier).state = user.asData!.value;
    }
  }

  @override
  FutureOr<void> build() {}
}
