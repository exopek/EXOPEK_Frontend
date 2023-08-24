import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AreaSelection extends StatelessWidget {
  final String assetPath;
  final String label;

  const AreaSelection(
      {super.key, required this.assetPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 79,
      height: 101,
      child: Stack(
        children: [
          Positioned(
            left: 4,
            top: 0,
            child: Container(
              width: 70,
              height: 70,
              decoration: ShapeDecoration(
                color: Colors.black,
                shape: OvalBorder(
                  side: BorderSide(
                      width: 0.4, color: Colors.white.withOpacity(0.8)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 75,
            child: SizedBox(
              width: 79,
              height: 31,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: ThemeBase.of(context).labelMedium,
              ),
            ),
          ),
          Positioned(
            left: 9,
            top: 5,
            child: Container(
              width: 60,
              height: 60,
              decoration: ShapeDecoration(
                /* image: DecorationImage(
                  image: AssetImage(assetPath),
                  fit: BoxFit.cover,
                ), */
                shape: OvalBorder(
                  side: BorderSide(width: 0.1, color: Colors.white),
                ),
              ),
              /* child: LayoutBuilder(
                    builder: (context, BoxConstraints constraints) {
                  return ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      assetPath,
                      width: constraints.maxWidth - 30,
                      height: constraints.maxHeight - 30,
                    ),
                  );
                }) */
            ),
          ),
        ],
      ),
    );
  }
}
