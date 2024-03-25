import 'package:exopek_workout_app/components/CtaButton.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 329,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.workout.previewImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
              left: 83,
              top: 229,
              right: 83,
              child: CtaButton(
                label: "Workout starten",
                onPressed: () {
                  ref.read(selectedWorkoutIdProvider.notifier).state =
                      widget.workout.id;
                  AppRouter.goToWorkoutDetail();
                },
              )),
          Positioned(
            left: 32,
            top: 31,
            child: Text(
              'Workout of the Week',
              style: TextStyle(
                color: Color(0xFFD12626),
                fontSize: 32,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            left: 24,
            top: 70,
            child: SizedBox(
              width: 332,
              height: 92,
              child: Text(
                'Wie jede Woche haben wir auch deises Mal ein Workout was dich an deine Grenzen treibt. Starte jetzt und nimm die Herausforderung an.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
