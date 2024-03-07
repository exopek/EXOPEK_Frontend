import 'package:exopek_workout_app/presentation/Authentication/LoginButtonController.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final asyncLoginButtonControllerProvider =
    AsyncNotifierProvider.autoDispose<LoginButtonController, void>(
        () {
  return LoginButtonController();
});