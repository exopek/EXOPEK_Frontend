import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageController extends AutoDisposeAsyncNotifier<Map<String, String>> {
  LoginPageController();

  Future<Map<String, String>?> fetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('username') && prefs.containsKey('password')) {
      return {
        'username': prefs.getString('username') ?? '',
        'password': prefs.getString('password') ?? '',
      };
    }
    return null;
  }

  @override
  Future<Map<String, String>> build() async {
    state = const AsyncLoading();
    var loginData = await fetch();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (loginData != null) {
      state = AsyncData(loginData);
      return loginData;
    } else {
      state = AsyncError('', StackTrace.current);
      return {};
    }
  }
}