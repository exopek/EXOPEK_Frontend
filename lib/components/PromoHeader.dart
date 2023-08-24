import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:flutter/material.dart';

class PromoHeader extends StatelessWidget {
  final Workout workout;

  const PromoHeader({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 329,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 390,
              height: 329,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(workout.previewImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 93,
            top: 229,
            child: Container(
              width: 210,
              height: 50,
              decoration: ShapeDecoration(
                color: Color(0xFFD12626),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  'Workout Starten',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
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
                'Wie jede Woche haben wir auch deises Mal ein Workout was dich an deine Grenzen treibt. starte jetzt und nimm die Herausforderung an.',
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
