import 'package:exopek_workout_app/components/Onboarding/OnboardingSelectionButton.dart';
import 'package:exopek_workout_app/components/Shared/GenericAppBar.dart';
import 'package:exopek_workout_app/domain/Models/Enums/TrainingFrequencyType.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import '../../components/CtaButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrainingFrequencySelectionPage extends StatefulWidget {
  final Function(TrainingFrequencyType) onTrainingFrequencyTypeSelected;
  final Map<dynamic, dynamic> selection;
  const TrainingFrequencySelectionPage({super.key, required this.onTrainingFrequencyTypeSelected, required this.selection});

  @override
  State<TrainingFrequencySelectionPage> createState() => _TrainingFrequencySelectionPageState();
}

class _TrainingFrequencySelectionPageState extends State<TrainingFrequencySelectionPage> {
  late TrainingFrequencyType trainingFrequencyType;

  @override
  void initState() {
    super.initState();
    trainingFrequencyType = TrainingFrequencyType.None;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeBase.of(context).primaryBackground,
      appBar: GenericAppBar.build(context, AppLocalizations.of(context).trainingFrequencySelectionPageTitle),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 36.0, right: 36.0, top: 50.0),
              child: Text(AppLocalizations.of(context).trainingFrequencySelectionPageHeadline,
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
                                    trainingFrequencyType = TrainingFrequencyType.values[index];
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
                    widget.onTrainingFrequencyTypeSelected(trainingFrequencyType);
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
