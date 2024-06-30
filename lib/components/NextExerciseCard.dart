import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  String frequenceType(BuildContext context) => exerciseFrequenceType.isEmpty
      ? AppLocalizations.of(context).nextExerciseCardWorkoutStateFinish
      : exerciseFrequenceType == "0"
          ? "$reps ${AppLocalizations.of(context).nextExerciseCardFrequencyTypeReps}"
          : "$exerciseFrequenceType ${AppLocalizations.of(context).nextExerciseCardFrequencyTypeTime}";

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
      child: Row(
        children: [
          if (imageUrl != null)
            Container(
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
            
          if (imageUrl == null)
            Container(
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220,
                  child: Text(isRest ? AppLocalizations.of(context).nextExerciseCardWorkoutStatePause : title, style: ThemeBase.of(context).titleMedium.copyWith(
                    height: 0
                  ),
                  overflow: TextOverflow.ellipsis,),
                ),
                Text(frequenceType(context), style: ThemeBase.of(context).titleSmall.copyWith(
                  height: 0
                )),
              ],
            ),
          )  
          
        ],
      ),
    );
  }
}
