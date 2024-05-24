import 'dart:async';

import 'package:dio/dio.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/data/repository/UserRepository.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateUserButtonController extends AutoDisposeAsyncNotifier<void> {
  UpdateUserButtonController();

  void updateUser({required UpdateUserDto user}) async {
    final UserRepository userRepository = ref.read(userRepositoryProvider);
    final Dio _dio = ref.read(dioProvider);
    state = const AsyncLoading();
    try {
      await userRepository.updateUser(user);
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
    } finally {
      state = const AsyncValue.data(null);
    }
  }

  @override
  FutureOr<void> build() {}
}
