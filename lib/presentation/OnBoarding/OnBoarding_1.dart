import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppUtil.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool marketingConfirmed = false;
  bool privacyPolicyConfirmed = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(registerButtonControllerProvider, (previous, next) {
      if (next is AsyncData) {
        AppRouter.goToConfirmEmail();
      } else if (next is AsyncError) {
        next.whenOrNull(
            error: (error, stackTrace) =>
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: ThemeBase.of(context).secondaryBackground,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  content: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          error.toString(),
                          style: TextStyle(
                            color: ThemeBase.of(context).primaryText,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )));
      }
    });
    final registerState = ref.watch(registerButtonControllerProvider);
    return Scaffold(
      backgroundColor: ThemeBase.of(context).primaryBackground,
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Werde Teil des EXOPEK-Teams!',
                textAlign: TextAlign.start,
                style: ThemeBase.of(context).headlineMedium.copyWith(
                      fontSize: 24,
                      color: ThemeBase.of(context).primaryText,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: controllerUsername,
                    hint: "Benutzername",
                    focusNode: focusNodeUsername,
                  ),
                  Spacer(),
                  CustomTextField(
                    controller: controllerPassword,
                    hint: "Passwort",
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
                  Spacer(),
                  CustomTextField(
                    controller: controllerEmail,
                    hint: "Email",
                    focusNode: focusNodeEmail,
                  ),
                  Spacer(),
                  CustomTextField(
                    controller: controllerFirstname,
                    hint: "Vorname",
                    focusNode: focusNodeFirstname,
                  ),
                  Spacer(),
                  CustomTextField(
                    controller: controllerLastname,
                    hint: "Nachname",
                    focusNode: focusNodeLastname,
                  ),
                ],
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: ThemeBase.of(context).secondary,
                  value: marketingConfirmed, 
                  onChanged: (value) {
                    setState(() {
                      marketingConfirmed = value!;
                    });
                  }),
                SizedBox(
                  width: 300,
                  child: Text( 
                    'Ich möchte über Neuigkeiten und Angebote informiert werden.',
                    style: ThemeBase.of(context).bodySmall,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 140.0),
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: ThemeBase.of(context).secondary,
                  value: privacyPolicyConfirmed, 
                  onChanged: (value) {
                    setState(() {
                      privacyPolicyConfirmed = value!;
                    });
                  }),
                SizedBox(
                  width: 300,
                  child: RichText(
            text: TextSpan(
              text: 'Ich habe die ',
              style: ThemeBase.of(context).bodySmall,
              children: <TextSpan>[
                TextSpan(
                  text: 'Datenschutzbestimmung ',
                  style: ThemeBase.of(context).bodySmall.copyWith(
                    color: ThemeBase.of(context).secondary,
                    decoration: TextDecoration.underline,
                  
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      const url = 'https://exopek.de/datenschutz/';
                      await launchURL(url);
                    },
                ),
                TextSpan(
                  text: 'gelesen und akzeptiere sie.',
                  style: ThemeBase.of(context).bodySmall
                ),
              ],
            ),
          ),/* Text( 
                    'Ich habe die Datenschutzbestimmung gelesen und akzeptiere sie.',
                    style: ThemeBase.of(context).bodySmall,
                  ), */
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 44.0, top: 20.0),
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
                      marketingConfirmed: marketingConfirmed,
                      privacyPolicyConfirmed: privacyPolicyConfirmed,
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
