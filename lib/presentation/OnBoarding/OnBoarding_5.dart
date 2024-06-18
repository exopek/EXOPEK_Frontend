import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../components/CtaButton.dart';
import '../../utils/AppRouter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:date_picker_plus/date_picker_plus.dart';

class OnBoarding5 extends StatefulWidget {
  final UpdateUserDto userDto;
  const OnBoarding5({super.key, required this.userDto});

  @override
  State<OnBoarding5> createState() => _OnBoarding5State();
}

class _OnBoarding5State extends State<OnBoarding5> {
  TextEditingController ageController = TextEditingController();
  FocusNode ageFocusNode = FocusNode();
  String? birthDate;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePickerDialog(
      context: context,
      initialDate: DateTime.now(),
      minDate: DateTime(1900),
      maxDate: DateTime.now(),
      slidersColor: Colors.redAccent,
      leadingDateTextStyle: const TextStyle(
        color: Colors.redAccent,
        fontSize: 20,
      ),
      currentDateDecoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.redAccent),
      ),
      currentDateTextStyle:
          const TextStyle(color: Colors.redAccent, fontSize: 20),
    );
    if (picked != NullableIndexedWidgetBuilder) {
      setState(() {
        if (picked == null) return;
        String formattedDate =
            DateFormat.yMMMMd(AppLocalizations.of(context).localeName)
                .format(picked!);
        ageController.text = formattedDate;
        birthDate = picked.toIso8601String();
      });
    }
  }

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
                AppLocalizations.of(context).birthDate,
                style: ThemeBase.of(context).headlineLarge,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 36.0, right: 36.0),
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: CustomTextField(
                    enabled: false,
                    numberKeyboard: true,
                    controller: ageController,
                    hint: AppLocalizations.of(context).textFieldHintBirthDate,
                    focusNode: ageFocusNode,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, right: 36.0),
              child: CtaButton(
                label: AppLocalizations.of(context).nextButton,
                onPressed: () {
                  var userDto = widget.userDto.copyWith(
                    birthDate: birthDate,
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
