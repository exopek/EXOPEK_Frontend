import 'package:exopek_workout_app/components/Onboarding/OnboardingSelectionButton.dart';
import 'package:exopek_workout_app/domain/Models/Enums/SportType.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';

import '../../components/CtaButton.dart';
import '../../utils/AppRouter.dart';

class SportTypeSelectionPage extends StatefulWidget {
  final Function(SportType) onSportTypeSelected;
  const SportTypeSelectionPage({super.key, required this.onSportTypeSelected});

  @override
  State<SportTypeSelectionPage> createState() => _SportTypeSelectionPageState();
}

class _SportTypeSelectionPageState extends State<SportTypeSelectionPage> {
  late Map selection;
  late SportType sportType;

  @override
  void initState() {
    super.initState();
    selection = SportType.values
        .asMap()
        .map((key, value) => MapEntry(value.name.toString(), false));
    sportType = SportType.None;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeBase.of(context).primaryBackground,
      appBar: AppBar(
        title: Text('Sportart auswählen'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 36.0, right: 36.0, top: 50.0),
              child: Text('In welchem Sport bist Du aktiv?',
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
                                    sportType = SportType.values[index];
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
