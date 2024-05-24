import 'package:dio/dio.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/data/repository/UserRepository.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/ProfilEditPageViewModel.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/ProfilPageViewModel.dart';
import 'package:exopek_workout_app/presentation/Authentication/LoginButtonController.dart';
import 'package:exopek_workout_app/presentation/Authentication/LoginPageController.dart';
import 'package:exopek_workout_app/presentation/ForgotPassword/ResetButtonController.dart';
import 'package:exopek_workout_app/presentation/OnBoarding/Controller/RegisterButtonController.dart';
import 'package:exopek_workout_app/presentation/OnBoarding/Controller/UpdateUserButtonController.dart';
import 'package:exopek_workout_app/presentation/Profil/ProfilPageController.dart';
import 'package:exopek_workout_app/presentation/Profil/UploadProfilImageButtonController.dart';
import 'package:exopek_workout_app/presentation/ProfilEdit/ProfilEditPageController.dart';
import 'package:exopek_workout_app/presentation/ProfilEdit/ProfilEditPageUpdateUserButtonController.dart';
import 'package:exopek_workout_app/presentation/Settings/DeleteUserController.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/OnBoarding/Controller/CheckValidTokenController.dart';

final userStateProvider = StateProvider<User?>((ref) {
  return null;
});

final asyncCheckValidTokenStateProvider = AsyncNotifierProvider.autoDispose<CheckValidTokenController ,bool>(() {
  return CheckValidTokenController();
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
  /// <summary>
  /// User is a state provider that is used to store the user data in the app
  /// </summary>
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

final asyncResetPasswordButtonControllerProvider =
    AsyncNotifierProvider.autoDispose<ResetButtonController, void>(() {
  return ResetButtonController();
});

final asyncUserCredentialsProvider =
    AsyncNotifierProvider.autoDispose<LoginPageController, Map<String, String>>(() {
  return LoginPageController();
});

final asyncDeleteUserControllerProvider =
    AsyncNotifierProvider.autoDispose<DeleteUserController, void>(() {
  return DeleteUserController();
});
