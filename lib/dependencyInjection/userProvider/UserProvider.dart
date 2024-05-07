import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/data/repository/UserRepository.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/ProfilEditPageViewModel.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/ProfilPageViewModel.dart';
import 'package:exopek_workout_app/presentation/Authentication/LoginButtonController.dart';
import 'package:exopek_workout_app/presentation/OnBoarding/Controller/RegisterButtonController.dart';
import 'package:exopek_workout_app/presentation/OnBoarding/Controller/UpdateUserButtonController.dart';
import 'package:exopek_workout_app/presentation/Profil/ProfilPageController.dart';
import 'package:exopek_workout_app/presentation/Profil/UploadProfilImageButtonController.dart';
import 'package:exopek_workout_app/presentation/ProfilEdit/ProfilEditPageController.dart';
import 'package:exopek_workout_app/presentation/ProfilEdit/ProfilEditPageUpdateUserButtonController.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStateProvider = StateProvider<User?>((ref) {
  return null;
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref);
});

final asyncLoginButtonControllerProvider =
    AsyncNotifierProvider.autoDispose<LoginButtonController, void>(
        () {
  return LoginButtonController();
});

final registerButtonControllerProvider =
    AsyncNotifierProvider.autoDispose<RegisterButtonController, void>(() {
  return RegisterButtonController();
});

final updateUserButtonControllerProvider =
    AsyncNotifierProvider.autoDispose<UpdateUserButtonController, void>(() {
  return UpdateUserButtonController();
});

final userProvider = FutureProvider.autoDispose<ReadUserDto>((ref) async {
  final data = await ref.watch(userRepositoryProvider).getUser();
  ref.read(userStateProvider.notifier).state = data;
  return data;
});

final asyncProfilPageControllerProvider = 
    AsyncNotifierProvider.autoDispose<ProfilPageController, ProfilPageViewModel>(() {
  return ProfilPageController();
    });

final uploadProfilImageButtonControllerProvider =
    AsyncNotifierProvider.autoDispose<UploadProfilImageButtonController, void>(() {
  return UploadProfilImageButtonController();
});

final asyncProfilEditPageControllerProvider = 
    AsyncNotifierProvider.autoDispose<ProfilEditPageController, ProfilEditPageViewModel>(() {
  return ProfilEditPageController();
    });

final asyncProfilEditPageUpdateUserButtonControllerProvider =
    AsyncNotifierProvider.autoDispose<ProfilEditPageUpdateUserButtonController, void>(() {
  return ProfilEditPageUpdateUserButtonController();
});
