import 'dart:async';

import 'package:dio/dio.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/data/repository/UserRepository.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetButtonController extends AutoDisposeAsyncNotifier<void> {
  ResetButtonController();

  void resetPassword(String email) async {
    final UserRepository userRepository = ref.read(userRepositoryProvider);
    final Dio _dio = ref.read(dioProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => userRepository.resetPassword(email));
    if (state is AsyncError) {
      state = AsyncValue.error(state.asError!.error.toString(), StackTrace.current);
    }
    
  }

  @override
  FutureOr<void> build() {}
}