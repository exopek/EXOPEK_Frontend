import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/CtaButton.dart';
import '../../utils/AppRouter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoarding2 extends ConsumerStatefulWidget {
  const OnBoarding2({super.key});

  @override
  ConsumerState<OnBoarding2> createState() => _OnBoarding2State();
}

class _OnBoarding2State extends ConsumerState<OnBoarding2> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userStateProvider);
    return Scaffold(
      backgroundColor: ThemeBase.of(context).primaryBackground,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '${AppLocalizations.of(context).welcomeUserText1} ${user!.firstname} ${AppLocalizations.of(context).welcomeUserText2}',
              style: ThemeBase.of(context).headlineLarge,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 56.0, top: 16.0),
              child: Text(
                AppLocalizations.of(context).welcomeUserText3,
                style: ThemeBase.of(context).headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 54.0),
              child: CtaButton(
                label: AppLocalizations.of(context).nextButton,
                onPressed: () {
                  AppRouter.goToOnBoarding3();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
