import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import '../../components/CtaButton.dart';
import '../../utils/AppRouter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoarding5 extends StatefulWidget {
  final UpdateUserDto userDto;
  const OnBoarding5({super.key, required this.userDto});

  @override
  State<OnBoarding5> createState() => _OnBoarding5State();
}

class _OnBoarding5State extends State<OnBoarding5> {
  TextEditingController ageController = TextEditingController();
  FocusNode ageFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeBase.of(context).primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                    const EdgeInsets.only(left: 36.0, right: 36.0, top: 50.0),
              child: Text(
                AppLocalizations.of(context).whichAge,
                style: ThemeBase.of(context).headlineLarge,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 36.0, right: 36.0),
                child: CustomTextField(
                  numberKeyboard: true,
                  controller: ageController,
                  hint: AppLocalizations.of(context).textFieldHintAge,
                  focusNode: ageFocusNode,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, right: 36.0),
              child: CtaButton(
                label: AppLocalizations.of(context).nextButton,
                onPressed: () {
                  var userDto = widget.userDto.copyWith(
                    age: int.tryParse(ageController.text),
                  );
                  AppRouter.goToOnBoarding6(userDto);
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
