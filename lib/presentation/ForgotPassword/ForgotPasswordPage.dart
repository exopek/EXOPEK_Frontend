import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                child: Text(AppLocalizations.of(context).succedMessageForgotPassword,
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
      backgroundColor: ThemeBase.of(context).primaryBackground,
      body: Column(
        children: [
          const SizedBox(height: 100),
          Text(AppLocalizations.of(context).forgotPasswordTitle1,
          style: ThemeBase.of(context).headlineMedium.copyWith(
            color: ThemeBase.of(context).primaryText,
          )),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
            child: Text(AppLocalizations.of(context).forgotPasswordTitle2,
            textAlign: TextAlign.center,
            style: ThemeBase.of(context).bodySmall.copyWith(
              color: ThemeBase.of(context).primaryText,
              fontSize: 14,
              height: 0,
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
            child: CustomTextField(
                focusNode: FocusNode(),
                controller: emailController,
                hint: AppLocalizations.of(context).textFieldHintEmail,
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
            child: CtaButton(
              onPressed: () {
                ref.read(asyncResetPasswordButtonControllerProvider.notifier).resetPassword(emailController.text);
              },
              label: AppLocalizations.of(context).resetPasswordButton,
              isLoading: state.isLoading,
            ),
          ),
        ],
      )
    );
  }
}