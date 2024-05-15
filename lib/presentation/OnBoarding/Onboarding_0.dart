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
    ref.listen(asyncCheckValidTokenStateProvider, (previous, next) {
      if (next is AsyncData) {
        next.whenData((value) {
          if (value) {
            //AppRouter.goToMainPage();
          }
        });
      }
     });
    final state = ref.watch(asyncCheckValidTokenStateProvider);
    return Scaffold(
      body: 
         Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
                      left: 0,
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
                                width: 120,
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
              )
       
          

          
      
    );
  }
}
