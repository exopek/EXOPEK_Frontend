import 'dart:math';

import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
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
        if (next.error.toString().contains('401')) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: ThemeBase.of(context).primaryBackground,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.red),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Benutzername oder Passwort ist falsch!',
                  style: TextStyle(
                    color: ThemeBase.of(context).primaryText,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),),
                ),
              ],
            ),
          ));
        } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error.toString()),
        ));
      }}
    });
    final loginButtonState = ref.watch(asyncLoginButtonControllerProvider);
    final pageState = ref.watch(asyncUserCredentialsProvider);
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
            child: GestureDetector(
              onTap: () {
                AppRouter.goToResetPassword();
              },
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
            right: 40,
            top: 260,
            child: CustomTextField(
              
              controller: usernameController,
              hint: 'Benutzername',
              focusNode: usernameFocusNode,
              
            ),
          ),
          Positioned(
            left: 40,
            right: 40,
            top: 343,
            child: CustomTextField(
              
              controller: passwordController,
              hint: 'Passwort',
              focusNode: passwordFocusNode,
              
              )
          ),
        ],
      ),
    ));
  }
}
