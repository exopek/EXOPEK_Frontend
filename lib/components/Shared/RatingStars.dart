import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double? size;
  const RatingStars({super.key, required this.rating, this.size});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          for (var i = 0; i < 5; i++)
            Icon(
              rating.round() > i ? Icons.star : Icons.star_border,
              color: rating.round() > i ? Color(0xFFE5C558) : ThemeBase.of(context).primaryText,
              size: size ?? 14,
            ),
        ]),
    );
  }
}