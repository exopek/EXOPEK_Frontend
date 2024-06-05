import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/ThemeBase.dart';
import '../../utils/AppRouter.dart';

class OnBoarding0 extends ConsumerStatefulWidget {
  const OnBoarding0({super.key});

  @override
  ConsumerState<OnBoarding0> createState() => _OnBoarding_0State();
}

class _OnBoarding_0State extends ConsumerState<OnBoarding0> {
  @override
  Widget build(BuildContext context) {
    /* ref.listen(asyncCheckValidTokenStateProvider, (previous, next) {
      if (next is AsyncData) {
        next.whenData((value) {
          if (value) {
            //AppRouter.goToMainPage();
          }
        });
      }
    }); */
    // final state = ref.watch(asyncCheckValidTokenStateProvider);
    return Scaffold(
        backgroundColor: ThemeBase.of(context).primaryBackground,
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/startImage.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 0,
                top: 65,
                child: Image(
                  image: AssetImage('assets/images/app_launcher_icon.png'),
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 50.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.53,
                        child: CtaButton(
                          color: Colors.transparent,
                          hasBorder: true,
                          label: 'Registrieren',
                          onPressed: () {
                            AppRouter.goToRegister();
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.35,
                        child: CtaButton(
                          color: Colors.transparent,
                          hasBorder: true,
                          label: 'Login',
                          onPressed: () {
                            AppRouter.goToLogin();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
