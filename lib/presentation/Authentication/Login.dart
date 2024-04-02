import 'dart:math';

import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error.toString()),
        ));
      }
    });
    final loginButtonState = ref.watch(asyncLoginButtonControllerProvider);
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: 844,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Color(0xFF161616)),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 844,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/images/loginImage.jpg"),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: 97,
            top: 73,
            child: Container(
              width: 200,
              height: 112.28,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/app_launcher_icon.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 108,
            top: 205,
            child: Text(
              'Anmedlung',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 112,
            top: 510,
            child: Text(
              'Passwort vergessen?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Positioned(
              top: 445,
              left: 50,
              right: 50,
              child: CtaButton(
                label: 'Anmelden',
                isLoading: loginButtonState.isLoading,
                onPressed: () {
                  ref.read(asyncLoginButtonControllerProvider.notifier).login(usernameController.text, passwordController.text);
                },
              )),
          Positioned(
            left: 40,
            top: 260,
            child: CustomTextField(
              xsize: 0.8,
              controller: usernameController,
              hint: 'Benutzername',
              focusNode: usernameFocusNode,
              icon: Icon(
                Icons.verified_user,
                color: Color(0xFF838282),
                size: 16,
              ),
            ),
          ),
          Positioned(
            left: 40,
            top: 343,
            child: CustomTextField(
              xsize: 0.8,
              controller: passwordController,
              hint: 'Passwort',
              focusNode: passwordFocusNode,
              icon: Icon(
                Icons.lock,
                color: Color(0xFF838282),
                size: 16,
              ),
              )
          ),
        ],
      ),
    ));
  }
}
