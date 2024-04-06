import 'package:exopek_workout_app/components/Onboarding/OnboardingSelectionButton.dart';
import 'package:exopek_workout_app/domain/Models/Enums/SportType.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:flutter/material.dart';

import '../../components/CtaButton.dart';
import '../../utils/AppRouter.dart';

class OnBoarding4 extends StatefulWidget {
  final UpdateUserDto userDto;
  const OnBoarding4({super.key, required this.userDto});

  @override
  State<OnBoarding4> createState() => _OnBoarding4State();
}

class _OnBoarding4State extends State<OnBoarding4> {
  late Map selection;
  late SportType sportType;

  @override
  void initState() {
    super.initState();
    selection = {
      'Kampfsport': false,
      'Gesundheitssport': false,
      'Teamsport': false,
      'Fitness': false
    };
    sportType = SportType.none;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
        child: Stack(
          children: [
            Positioned(
              left: 38,
              top: 40,
              child: Container(
                  width: 84,
                  height: 64,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Container()),
            ),
            Positioned(
              left: 36,
              top: 133,
              child: SizedBox(
                width: 327,
                child: Text(
                  'In welchem Sport bist Du aktiv?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
                    left: 36,
                    top: 228,
                    child: Container(
                        height: 400,
                        width: MediaQuery.of(context).size.width-72,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: selection.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 314,
                                height: 67,
                                child: OnboardingSelectionButton(
                                    text:
                                        selection.keys.toList()[index].toString(),
                                    isSelected:
                                        selection.values.toList()[index] as bool,
                                    onTap: (bool isSelected) {
                                      if (isSelected) {
                                        setState(() {
                                          selection.forEach((key, value) {
                                            if (key ==
                                                selection.keys.toList()[index]) {
                                              selection[key] = true;
                                              sportType = SportType.values[index+1];

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
                        ))),
            Positioned(
              left: 32,
              right: 32,
              top: 700,
              child: CtaButton(
                label: 'Weiter',
                onPressed: () {
                  var userDto = widget.userDto.copyWith(sport: sportType.index);
                  AppRouter.goToOnBoarding5(userDto);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
