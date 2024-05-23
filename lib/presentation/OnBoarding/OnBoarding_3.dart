import 'package:exopek_workout_app/components/Onboarding/OnboardingSelectionButton.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/Enums/SportType.dart';
import 'package:exopek_workout_app/domain/Models/Enums/TrainingFrequencyType.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/CtaButton.dart';
import '../../utils/AppRouter.dart';

class OnBoarding3 extends ConsumerStatefulWidget {
  const OnBoarding3({super.key});

  @override
  ConsumerState<OnBoarding3> createState() => _OnBoarding3State();
}

class _OnBoarding3State extends ConsumerState<OnBoarding3> {
  late UpdateUserDto updateUserDto;
  late Map selection;
  late TrainingFrequencyType previousTrainingFrequency;

  @override
  void initState() {
    super.initState();
    updateUserDto = UpdateUserDto(
      id: '',
      username: '',
      password: '',
      email: '',
      lastname: '',
      firstname: '',
      roles: [],
      sport: SportType.None,
    );
    selection = TrainingFrequencyType.values
        .asMap()
        .map((key, value) => MapEntry(value.name.toString(), false));
    previousTrainingFrequency = TrainingFrequencyType.None;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return user.when(
      data: (user) {
        updateUserDto = UpdateUserDto(
          id: user.id,
          username: user.username,
          password: user.password,
          email: user.email,
          lastname: user.lastname,
          firstname: user.firstname,
          roles: user.roles,
          sport: user.sport,
          trainingFrequency: user.trainingFrequency,
          previousTrainingFrequency: user.previousTrainingFrequency,
        );
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
                      'Wie oft trainierst Du pro Woche?',
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
                                              previousTrainingFrequency = TrainingFrequencyType.values[index];

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
                      updateUserDto = updateUserDto.copyWith(
                          previousTrainingFrequency: previousTrainingFrequency);
                      AppRouter.goToOnBoarding4(updateUserDto);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () {
        return Align(
            alignment: Alignment.topCenter, child: CircularProgressIndicator(strokeWidth: 0.5, color: ThemeBase.of(context).secondary,));
      },
      error: (error, stack) {
        throw Exception(error);
      },
    );
  }
}
