import 'dart:async';

import 'package:dio/dio.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/data/repository/UserRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginButtonController extends AutoDisposeAsyncNotifier<void> {
  LoginButtonController();

  void login(String username, String password) async {
    final UserRepository userRepository = ref.read(userRepositoryProvider);
    final Dio _dio = ref.read(dioProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => userRepository.login(username, password));
    if (state is AsyncError) {
      state = AsyncError("Plan could not be fetched", StackTrace.current);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (state is AsyncData) {
      prefs.setString('jwt_token', (state as AsyncData).value.toString());
      _dio.options.headers["Authorization"] =
          "Bearer ${prefs.getString('jwt_token')}";
    }
  }

  @override
  FutureOr<void> build() {}
}
