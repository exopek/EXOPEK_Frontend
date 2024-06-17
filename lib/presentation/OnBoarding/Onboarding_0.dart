import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    var localization = AppLocalizations.of(context).localeName;
    return Scaffold(
        backgroundColor: ThemeBase.of(context).primaryBackground,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/startImage.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image(
                    image: AssetImage('assets/images/app_launcher_icon.png'),
                    height: 100,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: CtaButton(
                          color: Colors.transparent,
                          hasBorder: true,
                          label: AppLocalizations.of(context).rigisterButton,
                          onPressed: () {
                            ref.read(localizationProvider.notifier).state =
                                localization;
                            AppRouter.goToRegister();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: CtaButton(
                          color: Colors.transparent,
                          hasBorder: true,
                          label: AppLocalizations.of(context).loginButton,
                          onPressed: () {
                            ref.read(localizationProvider.notifier).state =
                                localization;
                            AppRouter.goToLogin();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
