import 'dart:async';
import 'dart:io';

import 'package:exopek_workout_app/data/repository/UserRepository.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadProfilImageButtonController extends AutoDisposeAsyncNotifier<void> {
  // StateNotifier<AsyncValue<void>>
  UploadProfilImageButtonController();

  void updateUserImage({required File file}) async {
    final UserRepository userRepository = ref.read(userRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => userRepository.uploadProfilImage(file));
    if (state is AsyncError) {
      state = AsyncError('Failure to register!', StackTrace.current);
    }
    final user = await AsyncValue.guard(() => userRepository.getUser());
    if (user is AsyncError) {
      state = AsyncError('Failure to register!', StackTrace.current);
    }
    ref.read(userStateProvider.notifier).state = user.asData!.value;
  }

  @override
  FutureOr<void> build() {}
}