import 'dart:async';

import 'package:dio/dio.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/data/repository/UserRepository.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilEditPageUpdateUserButtonController
    extends AutoDisposeAsyncNotifier<void> {
  ProfilEditPageUpdateUserButtonController();

  void updateUser({required UpdateUserDto user}) async {
    final UserRepository userRepository = ref.read(userRepositoryProvider);
    final Dio _dio = ref.read(dioProvider);
    state = const AsyncLoading();
    var errorMessage = "";
    
      try {
        await userRepository.updateUser(user);
        state = const AsyncValue.data(null);
      } catch (e) {
        if (e is DioException) {
          if (e.response != null && e.response!.data != null) {
            errorMessage = e.response!.data[0].toString();
          } else {
            errorMessage = e.message.toString();
          }
        } else {
          errorMessage = e.toString();
        }
        state = AsyncError(errorMessage, StackTrace.current);
      }
  }

  @override
  FutureOr<void> build() {}
}
