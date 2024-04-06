import 'package:exopek_workout_app/components/CustomTextField.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:flutter/material.dart';

import '../../components/CtaButton.dart';
import '../../utils/AppRouter.dart';

class OnBoarding5 extends StatefulWidget {
  final UpdateUserDto userDto;
  const OnBoarding5({super.key, required this.userDto});

  @override
  State<OnBoarding5> createState() => _OnBoarding5State();
}

class _OnBoarding5State extends State<OnBoarding5> {
  TextEditingController ageController = TextEditingController();
  FocusNode ageFocusNode = FocusNode();
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
                  'Wie alt bist Du?',
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
              left: 38,
              top: 204,
              child: Text(
                'Alter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 36,
              right: 36,
              top: 228,
              child: CustomTextField(
                
                controller: ageController,
                hint: 'Alter',
                focusNode: ageFocusNode,
              ),
            ),
            
            Positioned(
              left: 32,
              right: 32,
              top: 700,
              child: CtaButton(
                label: 'Weiter',
                onPressed: () {
                  var userDto = widget.userDto.copyWith(
                    age: int.parse(ageController.text),
                  );
                  AppRouter.goToOnBoarding6(userDto);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
