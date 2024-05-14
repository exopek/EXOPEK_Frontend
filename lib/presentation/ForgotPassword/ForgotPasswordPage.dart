import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/presentation/ForgotPassword/ResetButtonController.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(asyncResetPasswordButtonControllerProvider, (previous, next) {
      if (next is AsyncData) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: ThemeBase.of(context).primaryBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Row(
            children: [
              const Icon(Icons.check, color: Colors.green),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Email gesendet! Bitte überprüfe dein Postfach.',
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
        AppRouter.goToLogin();
      }
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error.toString()),
        ));
      }
     });
    final state = ref.watch(asyncResetPasswordButtonControllerProvider);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          const Text('Passwort vergessen?',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
            child: const Text('Keine Sorge das passiert den Besten von uns. Trage deine Email ein und wir senden dir eine Url zum Zurücksetzten deines Passworts.',
            textAlign: TextAlign.center,
            style: TextStyle()),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
            child: CustomTextField(
                focusNode: FocusNode(),
                controller: emailController,
                hint: 'Email',
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
            child: CtaButton(
              onPressed: () {
                ref.read(asyncResetPasswordButtonControllerProvider.notifier).resetPassword(emailController.text);
              },
              label: 'Senden',
              isLoading: state.isLoading,
            ),
          ),
        ],
      )
    );
  }
}