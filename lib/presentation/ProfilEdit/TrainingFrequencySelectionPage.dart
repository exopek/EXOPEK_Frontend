import 'package:exopek_workout_app/components/Onboarding/OnboardingSelectionButton.dart';
import 'package:exopek_workout_app/components/Shared/GenericAppBar.dart';
import 'package:exopek_workout_app/domain/Models/Enums/SportType.dart';
import 'package:exopek_workout_app/domain/Models/Enums/TrainingFrequencyType.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';

import '../../components/CtaButton.dart';
import '../../utils/AppRouter.dart';

class TrainingFrequencySelectionPage extends StatefulWidget {
  final Function(TrainingFrequencyType) onTrainingFrequencyTypeSelected;
  const TrainingFrequencySelectionPage({super.key, required this.onTrainingFrequencyTypeSelected});

  @override
  State<TrainingFrequencySelectionPage> createState() => _TrainingFrequencySelectionPageState();
}

class _TrainingFrequencySelectionPageState extends State<TrainingFrequencySelectionPage> {
  late Map selection;
  late TrainingFrequencyType trainingFrequencyType;

  @override
  void initState() {
    super.initState();
    selection = TrainingFrequencyType.values
        .asMap()
        .map((key, value) => MapEntry(value.name.toString(), false));
    trainingFrequencyType = TrainingFrequencyType.None;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeBase.of(context).primaryBackground,
      appBar: GenericAppBar.build(context, 'Trainingsfrequenz'),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 36.0, right: 36.0, top: 50.0),
              child: Text('Wie oft trainierst Du pro Woche?',
                  style: ThemeBase.of(context).headlineLarge),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: selection.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16.0, left: 36.0, right: 36.0),
                    child: SizedBox(
                      height: 67,
                      child: OnboardingSelectionButton(
                          text: selection.keys.toList()[index].toString(),
                          isSelected: selection.values.toList()[index] as bool,
                          onTap: (bool isSelected) {
                            if (isSelected) {
                              setState(() {
                                selection.forEach((key, value) {
                                  if (key == selection.keys.toList()[index]) {
                                    selection[key] = true;
                                    trainingFrequencyType = TrainingFrequencyType.values[index];
                                  } else {
                                    selection[key] = false;
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
                  label: 'Übernehmen',
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
