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
            left: 0,
            top: 0,
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: OvalBorder(
                      side: BorderSide(
                          width: 0.5, color: Colors.white.withOpacity(0.8)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(label,
                      textAlign: TextAlign.center,
                      style: ThemeBase.of(context).labelMedium.copyWith(
                            fontSize: 10,
                            color: Color(0xFF838282),
                          )),
                ),
              ],
            ),
          ),
          Positioned(
            left: 5,
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
                    side: BorderSide(width: 0.5, color: Colors.white),
                  ),
                ),
                child: Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                    scale: 2.0,
                    image: AssetImage(assetPath),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ))
                /* child: LayoutBuilder(
                    builder: (context, BoxConstraints constraints) {
                  return Container(
                      width: 100, //constraints.maxWidth,
                      height: 100, //constraints.maxHeight,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(assetPath),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ));
                  /* ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      assetPath,
                      width: 200,
                      height: 200,
                    ),
                  ) */
                  ;
                }) */
                ),
          ),
        ],
      ),
    );
  }
}
