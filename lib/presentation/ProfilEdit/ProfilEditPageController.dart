import 'dart:async';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/ProfilEditPageViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilEditPageController extends AutoDisposeAsyncNotifier<ProfilEditPageViewModel> {
  ProfilEditPageController();

  Future<ProfilEditPageViewModel> fetch() async {
    final userRepository = ref.read(userRepositoryProvider);
    state = const AsyncLoading();
    final user = await AsyncValue.guard(() => userRepository.getUser());
    if (user is AsyncError) {
      state = AsyncError("User could not be fetched", StackTrace.current);
    }
    
    return ProfilEditPageViewModel(
        user: user.asData!.value);
  }

  @override
  FutureOr<ProfilEditPageViewModel> build() {
    return fetch();
  }
}