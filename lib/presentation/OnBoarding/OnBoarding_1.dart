import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/components/GenericSnackBar.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppUtil.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/CtaButton.dart';
import '../../utils/AppRouter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final TextEditingController controllerConfirmPassword =
      TextEditingController();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeFirstname = FocusNode();
  final FocusNode focusNodeLastname = FocusNode();
  final FocusNode focusNodeUsername = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  bool marketingConfirmed = false;
  bool privacyPolicyConfirmed = false;

  bool _validateInputs() {
    if (!privacyPolicyConfirmed) {
      GenericSnackBar.showErrorSnackBar(
          context: context,
          text: AppLocalizations.of(context).errorMessagePrivacyPolicy);
      return false;
    }
    if (controllerEmail.text.isEmpty) {
      GenericSnackBar.showErrorSnackBar(
          context: context,
          text: AppLocalizations.of(context).userRegistrationEmail);
      return false;
    }
    if (controllerFirstname.text.isEmpty) {
      GenericSnackBar.showErrorSnackBar(
          context: context,
          text: AppLocalizations.of(context).userRegistrationFirstname);
      return false;
    }
    if (controllerLastname.text.isEmpty) {
      GenericSnackBar.showErrorSnackBar(
          context: context,
          text: AppLocalizations.of(context).userRegistrationLastname);
      return false;
    }
    if (controllerUsername.text.isEmpty) {
      GenericSnackBar.showErrorSnackBar(
          context: context,
          text: AppLocalizations.of(context).userRegistrationUsername);
      return false;
    }
    if (controllerPassword.text.isEmpty) {
      return false;
    }
    if (controllerPassword.text.length < 10) {
      return false;
    }
    if (!controllerPassword.text.contains(RegExp(r'[0-9]'))) {
      return false;
    }
    if (controllerConfirmPassword.text.isEmpty) {
      return false;
    }
    if (controllerConfirmPassword.text != controllerPassword.text) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(registerButtonControllerProvider, (previous, next) {
      if (next is AsyncData) {
        AppRouter.goToConfirmEmail();
      } else if (next is AsyncError) {
        next.whenOrNull(
            error: (error, stackTrace) => GenericSnackBar.showErrorSnackBar(
                context: context, text: error.toString()));
      }
    });
    final registerState = ref.watch(registerButtonControllerProvider);
    return Scaffold(
      backgroundColor: ThemeBase.of(context).primaryBackground,
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 20.0, top: 50.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context).welcomeUserRegistrationText,
                        textAlign: TextAlign.start,
                        style: ThemeBase.of(context).headlineMedium.copyWith(
                              fontSize: 24,
                              color: ThemeBase.of(context).primaryText,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextField(
                          controller: controllerUsername,
                          hint:
                              AppLocalizations.of(context).textFieldHintUsername,
                          focusNode: focusNodeUsername,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        CustomTextField(
                          controller: controllerFirstname,
                          hint:
                              AppLocalizations.of(context).textFieldHintFirstname,
                          focusNode: focusNodeFirstname,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        CustomTextField(
                          controller: controllerLastname,
                          hint:
                              AppLocalizations.of(context).textFieldHintLastname,
                          focusNode: focusNodeLastname,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        CustomTextField(
                          controller: controllerEmail,
                          hint: AppLocalizations.of(context).textFieldHintEmail,
                          focusNode: focusNodeEmail,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        CustomTextField(
                          controller: controllerPassword,
                          hint:
                              AppLocalizations.of(context).textFieldHintPassword,
                          focusNode: focusNodePassword,
                          obscureText: true,
                          errorText: AppLocalizations.of(context).userRegistrationPasswordNotValid,
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
                        const SizedBox(
                          height: 16.0,
                        ),
                        CustomTextField(
                          controller: controllerConfirmPassword,
                          hint: AppLocalizations.of(context)
                              .textFieldHintConfirmPassword,
                          focusNode: focusNodeConfirmPassword,
                          obscureText: true,
                          errorText: AppLocalizations.of(context).userRegistrationPasswordMismatch,
                          onValidate: (p0) {
                            if (p0.isEmpty) {
                              return false;
                            }
                            if (p0 != controllerPassword.text) {
                              return false;
                            }
                            return true;
                          },
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
                                  AppLocalizations.of(context).checkBoxNews,
                                  style: ThemeBase.of(context).bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
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
                                    text: AppLocalizations.of(context)
                                        .checkBoxPrivacyPolicy1,
                                    style: ThemeBase.of(context).bodySmall,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: AppLocalizations.of(context)
                                            .checkBoxPrivacyPolicy2,
                                        style: ThemeBase.of(context)
                                            .bodySmall
                                            .copyWith(
                                              color:
                                                  ThemeBase.of(context).secondary,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            const url =
                                                'https://exopek.de/datenschutz/';
                                            await launchURL(url);
                                          },
                                      ),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .checkBoxPrivacyPolicy3,
                                          style: ThemeBase.of(context).bodySmall),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
                          child: CtaButton(
                            isLoading: registerState.isLoading,
                            label: AppLocalizations.of(context).rigisterButton,
                            onPressed: () {
                              if (!_validateInputs()) {
                                return;
                              }
                              if (registerState.isLoading) return;
                              ref
                                  .read(registerButtonControllerProvider.notifier)
                                  .register(
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
        ),
          
        
      ),
    );
  }
}
