import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:flutter/material.dart';

import '../utils/AppRouter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 390,
      height: 844,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Color(0xFF161616)),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 390,
              height: 844,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/loginImage.jpg"),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: 97,
            top: 73,
            child: Container(
              width: 200,
              height: 112.28,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/app_launcher_icon.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 108,
            top: 205,
            child: Text(
              'Anmedlung',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 112,
            top: 510,
            child: Text(
              'Passwort vergessen?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Positioned(
              top: 445,
              left: 50,
              right: 50,
              child: CtaButton(
                label: 'Anmelden',
                onPressed: () {
                  AppRouter.goToMainPage();
                },
              )),
          Positioned(
            left: 40,
            top: 260,
            child: Container(
              width: 314,
              height: 67,
              decoration: ShapeDecoration(
                color: Color(0x00262323),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF262424)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Positioned(
            left: 40,
            top: 343,
            child: Container(
              width: 314,
              height: 67,
              decoration: ShapeDecoration(
                color: Color(0x00262323),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF262424)),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
