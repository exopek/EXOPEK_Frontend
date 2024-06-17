import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';

class NextExerciseCard extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final String exerciseFrequenceType;
  final String reps;
  final bool isRest;

  const NextExerciseCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.exerciseFrequenceType,
      required this.reps,
      required this.isRest});

  String get frequenceType => exerciseFrequenceType.isEmpty
      ? "Fertig"
      : exerciseFrequenceType == "0"
          ? "$reps Wiederholungen"
          : "$exerciseFrequenceType Sekunden";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 77,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0xFF262424)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          if (imageUrl != null)
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 77,
                height: 77,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.50, color: Color(0xFF262424)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          if (imageUrl == null)
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 77,
                height: 77,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.50, color: Color(0xFF262424)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.greenAccent,
                    size: 40,
                  ),
                ),
              ),
            ),
          Positioned(
            left: 88,
            top: 15,
            child: Text(isRest ? 'Pause' : title, style: ThemeBase.of(context).titleMedium),
          ),
          Positioned(
            left: 88,
            top: 39,
            child: Text(frequenceType,
                style: ThemeBase.of(context).titleSmall),
          ),
        ],
      ),
    );
  }
}
