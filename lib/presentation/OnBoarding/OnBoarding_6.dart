import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/CtaButton.dart';
import '../../utils/AppRouter.dart';

class OnBoarding6 extends ConsumerStatefulWidget {
  final UpdateUserDto userDto;
  const OnBoarding6({super.key, required this.userDto});

  @override
  ConsumerState<OnBoarding6> createState() => _OnBoarding6State();
}

class _OnBoarding6State extends ConsumerState<OnBoarding6> {
  TextEditingController heightController = TextEditingController();
  FocusNode heightFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    ref.listen(updateUserButtonControllerProvider, (previous, next) {
      if (next is AsyncData) {
        AppRouter.goToMainPage();
      } else if (next is AsyncError) {
        next.whenOrNull(
            error: (error, stackTrace) =>
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: ThemeBase.of(context).primaryBackground,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  content: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          error.toString(),
                          style: TextStyle(
                            color: ThemeBase.of(context).primaryText,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )));
      }
    });
    final state = ref.watch(updateUserButtonControllerProvider);
    return Scaffold(
      backgroundColor: ThemeBase.of(context).primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 36.0, right: 36.0, top: 50.0),
              child: Text(
                'Wie groß bist Du?',
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
                  controller: heightController,
                  hint: 'Körpergröße (cm)',
                  focusNode: heightFocusNode,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, right: 36.0),
              child: CtaButton(
                isLoading: state.isLoading,
                label: 'Weiter',
                onPressed: () {
                  var userDto = widget.userDto.copyWith(
                    height: double.tryParse(heightController.text),
                  );
                  ref
                      .read(updateUserButtonControllerProvider.notifier)
                      .updateUser(user: userDto);
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
