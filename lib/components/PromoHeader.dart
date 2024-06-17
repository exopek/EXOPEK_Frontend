import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PromoHeader extends ConsumerStatefulWidget {
  final Workout workout;

  const PromoHeader({super.key, required this.workout});

  @override
  ConsumerState<PromoHeader> createState() => _PromoHeaderState();
}

class _PromoHeaderState extends ConsumerState<PromoHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 329,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.workout.previewImageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  AppLocalizations.of(context).workoutsPromoHeaderTitle,
                  textAlign: TextAlign.center,
                  style: ThemeBase.of(context).headlineMedium.copyWith(
                        color: ThemeBase.of(context).secondary,
                        height: 0,
                      ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                    AppLocalizations.of(context).workoutsPromoHeaderContent,
                    textAlign: TextAlign.center,
                    style: ThemeBase.of(context).bodyMedium.copyWith(
                          fontSize: 18.0,
                          height: 0,
                        )),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: CtaButton(
              label: AppLocalizations.of(context)
                  .workoutsPromoHeaderStartWorkoutButton,
              onPressed: () {
                ref.read(selectedWorkoutIdProvider.notifier).state =
                    widget.workout.id;
                AppRouter.goToWorkoutDetail();
              },
            ),
          ),
        ],
      ),
    );
  }
}
