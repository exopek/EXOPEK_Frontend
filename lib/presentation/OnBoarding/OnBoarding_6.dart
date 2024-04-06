import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Update fehlgeschlagen."),
          ),
        );
      }
    });
    final state = ref.watch(updateUserButtonControllerProvider);
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
                  'Wie groß bist Du?',
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
              right: 36,
              top: 228,
              child: CustomTextField(
                
                controller: heightController,
                hint: 'Körpergröße (cm)',
                focusNode: heightFocusNode,
              ),
            ),
            Positioned(
              left: 32,
              right: 32,
              top: 700,
              child: CtaButton(
                isLoading: state.isLoading,
                label: 'Weiter',
                onPressed: () {
                  var userDto = widget.userDto.copyWith(
                    height: double.parse(heightController.text),
                  );
                  ref.read(updateUserButtonControllerProvider.notifier).updateUser(user: userDto);
                },
              ),
            ),
            Positioned(
              left: 38,
              top: 204,
              child: Text(
                'Körpergröße (cm)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
