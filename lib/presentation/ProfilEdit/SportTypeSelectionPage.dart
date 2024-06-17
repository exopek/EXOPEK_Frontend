import 'package:exopek_workout_app/components/Onboarding/OnboardingSelectionButton.dart';
import 'package:exopek_workout_app/components/Shared/GenericAppBar.dart';
import 'package:exopek_workout_app/domain/Models/Enums/SportType.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import '../../components/CtaButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SportTypeSelectionPage extends StatefulWidget {
  final Function(SportType) onSportTypeSelected;
  final Map<dynamic, dynamic> selection;
  const SportTypeSelectionPage({super.key, required this.onSportTypeSelected, required this.selection});

  @override
  State<SportTypeSelectionPage> createState() => _SportTypeSelectionPageState();
}

class _SportTypeSelectionPageState extends State<SportTypeSelectionPage> {
  late SportType sportType;

  @override
  void initState() {
    super.initState();
    sportType = SportType.None;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeBase.of(context).primaryBackground,
      appBar: GenericAppBar.build(context, AppLocalizations.of(context).sportTypeSelectionPageTitle),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 36.0, right: 36.0, top: 50.0),
              child: Text(AppLocalizations.of(context).sportTypeSelectionPageHeadline,
                  style: ThemeBase.of(context).headlineLarge),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.selection.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16.0, left: 36.0, right: 36.0),
                    child: SizedBox(
                      height: 67,
                      child: OnboardingSelectionButton(
                          text: widget.selection.keys.toList()[index].toString(),
                          isSelected: widget.selection.values.toList()[index] as bool,
                          onTap: (bool isSelected) {
                            if (isSelected) {
                              setState(() {
                                widget.selection.forEach((key, value) {
                                  if (key == widget.selection.keys.toList()[index]) {
                                    widget.selection[key] = true;
                                    sportType = SportType.values[index];
                                  } else {
                                    widget.selection[key] = false;
                                  }
                                });
                              });
                            }
                          }),
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, right: 36.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CtaButton(
                  label: AppLocalizations.of(context).lockChangesButton,
                  onPressed: () {
                    widget.onSportTypeSelected(sportType);
                    Navigator.pop(context);
                  },
                ),
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
