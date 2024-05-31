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
    return SizedBox(
      width: 79,
      height: 101,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const ShapeDecoration(
                  color: Colors.black,
                  shape: OvalBorder(
                    side: BorderSide(width: 0.5, color: Colors.white),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                      decoration: BoxDecoration(
                    image: DecorationImage(
                      scale: 2.0,
                      image: AssetImage(assetPath),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(label,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: ThemeBase.of(context).labelSmall.copyWith(
                          fontSize: 10,
                          color: ThemeBase.of(context).secondaryText,
                        )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
