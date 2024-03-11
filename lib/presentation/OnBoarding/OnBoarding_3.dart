import 'package:exopek_workout_app/components/Onboarding/OnboardingSelectionButton.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/data/repository/UserRepository.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
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

  @override
  void initState() {
    super.initState();
    updateUserDto = UpdateUserDto(
      username: '',
      password: '',
      email: '',
      lastname: '',
      firstname: '',
      roles: [],
    );
    selection = {
      'Unregelmäßig 0 - 1': false,
      'Regelmäßig 2 - 3': false,
      'Athlet 4 - 5': false,
      'Profi Athlet 6 - 7': false
    };
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return user.when(
      data: (user) {
        updateUserDto = UpdateUserDto(
          username: user.username,
          password: user.password,
          email: user.email,
          lastname: user.lastname,
          firstname: user.firstname,
          roles: user.roles,
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
                      AppRouter.goToOnBoarding4();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CircularProgressIndicator(),
        );
      },
      error: (error, stack) {
        throw Exception(error);
      },
    );
  }
}
