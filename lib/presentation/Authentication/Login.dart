import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/components/GenericSnackBar.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/AppRouter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            context: context, text: AppLocalizations.of(context).errorMessageLogin);
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
            child: 
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
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
                        AppLocalizations.of(context).loginTitle,
                        style: ThemeBase.of(context).headlineMedium.copyWith(
                              color: ThemeBase.of(context).primaryText,
                            ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      AutofillGroup(
                        child: Column(
                          children: [CustomTextField(
                            autofillHints: [AutofillHints.username],
                          controller: usernameController,
                          hint: AppLocalizations.of(context).textFieldHintUsernameOrEmail,
                          focusNode: usernameFocusNode,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        CustomTextField(
                          autofillHints: [AutofillHints.password],
                          controller: passwordController,
                          hint: AppLocalizations.of(context).textFieldHintPassword,
                          focusNode: passwordFocusNode,
                          obscureText: true,
                        ),],
                        ),
                      ),
                      
                      const SizedBox(
                        height: 16.0,
                      ),
                      CtaButton(
                        label: AppLocalizations.of(context).loginButton,
                        isLoading: loginButtonState.isLoading,
                        onPressed: () {
                          TextInput.finishAutofillContext();
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
                          AppLocalizations.of(context).forgetPassword,
                          style: ThemeBase.of(context).bodyMedium,
                        ),
                      ),
                        ],
                      ),
                      
                      GestureDetector(
                        onTap: () {
                          AppRouter.goToOnBoarding0();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 44.0),
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_back),
                              const SizedBox(width: 4,),
                              Text(
                                AppLocalizations.of(context).loginPageBackButton,
                                style: ThemeBase.of(context).bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              
            
          ),
        ));
  }
}
