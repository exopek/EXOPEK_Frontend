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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    previousTrainingFrequency = TrainingFrequencyType.None;
  }

  @override
  void didChangeDependencies() {
    selection = TrainingFrequencyType.values
        .asMap()
        .map((key, value) => MapEntry(value.name(context), false));
    super.didChangeDependencies();
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
          backgroundColor: ThemeBase.of(context).primaryBackground,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 36.0, right: 36.0, top: 50.0),
                  child: Text(AppLocalizations.of(context).trainingPerWeek,
                      style: ThemeBase.of(context).headlineLarge),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: selection.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 36.0, right: 36.0, bottom: 16.0),
                        child: SizedBox(
                          height: 67,
                          child: OnboardingSelectionButton(
                              text: selection.keys.toList()[index].toString(),
                              isSelected:
                                  selection.values.toList()[index] as bool,
                              onTap: (bool isSelected) {
                                if (isSelected) {
                                  setState(() {
                                    selection.forEach((key, value) {
                                      if (key ==
                                          selection.keys.toList()[index]) {
                                        selection[key] = true;
                                        previousTrainingFrequency =
                                            TrainingFrequencyType.values[index];
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
                  child: CtaButton(
                    label: AppLocalizations.of(context).nextButton,
                    onPressed: () {
                      updateUserDto = updateUserDto.copyWith(
                          previousTrainingFrequency: previousTrainingFrequency);
                      AppRouter.goToOnBoarding4(updateUserDto);
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
      },
      loading: () {
        return Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator(
              strokeWidth: 0.5,
              color: ThemeBase.of(context).secondary,
            ));
      },
      error: (error, stack) {
        throw Exception(error);
      },
    );
  }
}
