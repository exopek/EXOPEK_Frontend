import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:flutter/material.dart';

import '../../theme/ThemeBase.dart';
import '../../utils/AppRouter.dart';

class OnBoarding0 extends StatefulWidget {
  const OnBoarding0({super.key});

  @override
  State<OnBoarding0> createState() => _OnBoarding_0State();
}

class _OnBoarding_0State extends State<OnBoarding0> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 390,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/startImage.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 32,
              top: 589,
              child: SizedBox(
                width: 314,
                height: 30,
                child: Text('The Key To Your success',
                    textAlign: TextAlign.center,
                    style: ThemeBase.of(context).bodyMedium.copyWith(
                          fontSize: 28,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        )),
              ),
            ),
            Positioned(
              left: 32,
              top: 623,
              child: SizedBox(
                width: 337,
                height: 30,
                child: Text('Open Up A New Dimension',
                    textAlign: TextAlign.center,
                    style: ThemeBase.of(context).bodyMedium.copyWith(
                          fontSize: 28,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        )),
              ),
            ),
            Positioned(
              left: 32,
              top: 658,
              child: SizedBox(
                width: 139,
                height: 30,
                child: Text('Of Training',
                    textAlign: TextAlign.center,
                    style: ThemeBase.of(context).bodyMedium.copyWith(
                          fontSize: 28,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        )),
              ),
            ),
            Positioned(
              left: 32,
              top: 537,
              child: SizedBox(
                width: 218,
                height: 61,
                child: Text(
                  'EXOPEK Training',
                  textAlign: TextAlign.center,
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
              left: 32,
              top: 65,
              child: Container(
                width: 160,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/app_launcher_icon.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
                right: 32,
                left: 32,
                top: 727,
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: CtaButton(
                          label: 'Login',
                          onPressed: () {
                            AppRouter.goToLogin();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        width: 150,
                        child: CtaButton(
                          label: 'Register',
                          onPressed: () {
                            AppRouter.goToRegister();
                          },
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
