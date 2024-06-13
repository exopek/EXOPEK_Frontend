import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingCode extends ConsumerStatefulWidget {
  const OnBoardingCode({super.key});

  @override
  ConsumerState<OnBoardingCode> createState() => _OnBoardingCodeState();
}

class _OnBoardingCodeState extends ConsumerState<OnBoardingCode> {
  final TextEditingController controllerCode1 = TextEditingController();
  final TextEditingController controllerCode2 = TextEditingController();
  final TextEditingController controllerCode3 = TextEditingController();
  final TextEditingController controllerCode4 = TextEditingController();
  final TextEditingController controllerCode5 = TextEditingController();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final FocusNode focusNode5 = FocusNode();

  String get pinCode =>
      controllerCode1.text +
      controllerCode2.text +
      controllerCode3.text +
      controllerCode4.text +
      controllerCode5.text;

  @override
  Widget build(BuildContext context) {
    ref.listen(asyncConfirmEmailButtonControllerProvider, (previous, next) { 
      if (next is AsyncData) {
        AppRouter.goToRegisterSucceed();
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
    final state = ref.watch(asyncConfirmEmailButtonControllerProvider);
    final user = ref.watch(userStateProvider);
    return Scaffold(
      backgroundColor: ThemeBase.of(context).primaryBackground,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context).verificationCodeText,
                        style: ThemeBase.of(context).titleLarge,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _numberInputField(controllerCode1, focusNode1),
                      _numberInputField(controllerCode2, focusNode2),
                      _numberInputField(controllerCode3, focusNode3),
                      _numberInputField(controllerCode4, focusNode4),
                      _numberInputField(controllerCode5, focusNode5),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 44.0),
            child: CtaButton(label: AppLocalizations.of(context).sendCodeButton, isLoading: state.isLoading,
            onPressed: () {
              if (pinCode.length != 5) {
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
                          AppLocalizations.of(context).errorMessageVerificationCode,
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
                ));
                return;
              }
              ref.read(asyncConfirmEmailButtonControllerProvider.notifier).confirmEmail(pinCode: pinCode, email: user!.email);
            },),
          )
        ],
      ),
    );
  }

  Widget _numberInputField(TextEditingController controller, FocusNode focusNode) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: ThemeBase.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextField(
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          focusNode: focusNode,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          keyboardType: TextInputType.number,
          controller: controller,
          cursorHeight: 25,
          style: ThemeBase.of(context).labelLarge.copyWith(fontSize: 25),
          textAlign: TextAlign.center,
          maxLength: 1,
          buildCounter: (BuildContext context,
                  {int? currentLength, int? maxLength, bool? isFocused}) =>
              null,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(bottom: 3, left: 3),
          ),
        ),
      ),
    );
  }
}
