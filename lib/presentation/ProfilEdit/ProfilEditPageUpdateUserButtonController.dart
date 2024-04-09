import 'dart:async';

import 'package:dio/dio.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/data/repository/UserRepository.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilEditPageUpdateUserButtonController extends AutoDisposeAsyncNotifier<void> {
  ProfilEditPageUpdateUserButtonController();

  void updateUser({required UpdateUserDto user}) async {
    final UserRepository userRepository = ref.read(userRepositoryProvider);
    final Dio _dio = ref.read(dioProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => userRepository.updateUser(user));
    if (state is AsyncError) {
      state = AsyncError('Failure to register!', StackTrace.current);
    }
  }
  
  @override
  FutureOr<void> build() {
  }

}