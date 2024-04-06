import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/utils/AppUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/CtaButton.dart';
import '../../utils/AppRouter.dart';

class OnBoarding1 extends ConsumerStatefulWidget {
  const OnBoarding1({super.key});

  @override
  ConsumerState<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends ConsumerState<OnBoarding1> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerFirstname = TextEditingController();
  final TextEditingController controllerLastname = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeFirstname = FocusNode();
  final FocusNode focusNodeLastname = FocusNode();
  final FocusNode focusNodeUsername = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    ref.listen(registerButtonControllerProvider, (previous, next) {
      if (next is AsyncData) {
        AppRouter.goToRegisterSucceed();
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registrierung fehlgeschlagen."),
          ),
        );
      }
    });
    final registerState = ref.watch(registerButtonControllerProvider);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFF0C0C0C)),
        child: Stack(
          children: [
            const Positioned(
              left: 32,
              top: 44,
              child: Text(
                'Wir machen Dich',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            const Positioned(
              left: 32,
              top: 84,
              child: Text(
                'zum EXOPEK-Mitglied.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 32,
              top: 494,
              child: Container(
                width: 26,
                height: 26,
                decoration: ShapeDecoration(
                  color: const Color(0xFFD9D9D9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
            Positioned(
              left: 32,
              top: 591,
              child: Container(
                width: 26,
                height: 26,
                decoration: ShapeDecoration(
                  color: const Color(0xFFD9D9D9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
            const Positioned(
              left: 81,
              top: 494,
              child: SizedBox(
                width: 265,
                child: Text(
                  'Sign up for emails to get updates from EXOPEK on products, offers and your Memeber benefits.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 77,
              top: 591,
              child: SizedBox(
                width: 265,
                child: Text(
                  'I agree to EXOPEK’s Terms of Use and I confirm I have read EXOPEK’s Privacy Policy.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 32,
              right: 32,
              top: 155,
              child: CustomTextField(
                  controller: controllerUsername,
                  hint: "Username",
                  focusNode: focusNodeUsername,
                  ),
            ),
            Positioned(
              left: 32,
              right: 32,
              top: 404,
              child: CustomTextField(
                  controller: controllerPassword,
                  hint: "Password",
                  focusNode: focusNodePassword,
                  onValidate: (p0) {
                    if (p0.isEmpty) {
                      return false;
                    }
                    if (p0.length < 10) {
                      return false;
                    }
                    if (!p0.contains(RegExp(r'[0-9]'))) {
                      return false;
                    }
                    return true;
                  
                  },
                  ),
            ),
            Positioned(
                left: 32,
                right: 32,
                top: 321,
                child: CustomTextField(
                    controller: controllerEmail,
                    hint: "Email",
                    focusNode: focusNodeEmail,
                    )
            ),
            Positioned(
              left: 32,
              right: 200,
              top: 238,
              child: CustomTextField(
                  controller: controllerFirstname,
                  hint: "Firstname",
                  focusNode: focusNodeFirstname,
                  ),
            ),
            Positioned(
                left: 200,
                right: 32,
                top: 238,
                child: CustomTextField(
                    controller: controllerLastname,
                    hint: "Lastname",
                    focusNode: focusNodeLastname,
                    )
            ),
            Positioned(
              left: 32,
              right: 32,
              top: 706,
              child: CtaButton(
                isLoading: registerState.isLoading,
                label: 'Registrieren',
                onPressed: () {
                  //AppRouter.goToRegisterSucceed();
                  ref.read(registerButtonControllerProvider.notifier).register(
                        email: controllerEmail.text,
                        firstname: controllerFirstname.text,
                        lastname: controllerLastname.text,
                        username: controllerUsername.text,
                        password: controllerPassword.text,
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
