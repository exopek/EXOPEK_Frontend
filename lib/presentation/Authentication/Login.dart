import 'dart:math';

import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/components/GenericSnackBar.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../utils/AppRouter.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    ref.listen(asyncLoginButtonControllerProvider, (previous, next) {
      if (next is AsyncData) {
        AppRouter.goToMainPage();
      }
      if (next is AsyncError) {
        GenericSnackBar.showErrorSnackBar(
            context: context, text: 'Benutzername oder Passwort falsch');
      }
    });
    final loginButtonState = ref.watch(asyncLoginButtonControllerProvider);
    return Scaffold(
        backgroundColor: ThemeBase.of(context).primaryBackground,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 100.0),
                  child: Column(
                    children: [
                      Container(
                        width: 200,
                        height: 112.28,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/app_launcher_icon.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(
                        'Anmedlung',
                        style: ThemeBase.of(context).headlineMedium.copyWith(
                              color: ThemeBase.of(context).primaryText,
                            ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CustomTextField(
                        controller: usernameController,
                        hint: 'Benutzername',
                        focusNode: usernameFocusNode,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        hint: 'Passwort',
                        focusNode: passwordFocusNode,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CtaButton(
                        label: 'Anmelden',
                        isLoading: loginButtonState.isLoading,
                        onPressed: () {
                          ref
                              .read(asyncLoginButtonControllerProvider.notifier)
                              .login(usernameController.text,
                                  passwordController.text);
                        },
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          AppRouter.goToResetPassword();
                        },
                        child: Text(
                          'Passwort vergessen?',
                          style: ThemeBase.of(context).bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
