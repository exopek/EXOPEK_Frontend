import 'dart:async';

import 'package:exopek_workout_app/data/repository/UserRepository.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteUserController extends AutoDisposeAsyncNotifier<void> {
  DeleteUserController();

  void deleteUser() async {
    final UserRepository userRepository = ref.read(userRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => userRepository.deleteUser());
    if (state is AsyncError) {
      state = AsyncError('Failure to register!', StackTrace.current);
    }
  }

  @override
  FutureOr<void> build() {}
}