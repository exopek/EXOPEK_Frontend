import 'package:dio/dio.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckValidTokenController extends AutoDisposeAsyncNotifier<bool> {
  CheckValidTokenController();

  @override
  Future<bool> checkValidToken() async {
    state = const AsyncLoading();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Dio _dio = ref.read(dioProvider);
    if (prefs.getString('jwt_token') == null || prefs.containsKey('jwt_token') == false) {
      state = AsyncData(false);
      return false;
    }
    _dio.options.headers["Authorization"] =
            "Bearer ${prefs.getString('jwt_token')}";
    var value = await ref.watch(userRepositoryProvider).checkUserIsLogedIn();
    if (value == false) {
      state = AsyncData(false);
    } else {
      // ignore: void_checks
      state = AsyncData(true);
    }
    return true;

  }

  @override
  Future<bool> build() async {
    var value = await checkValidToken();
    return value;
  }
}