import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum DifficultyType {
  none,
  beginner,
  intermediate,
  advanced,
}

extension DifficultyTypeExtension on DifficultyType {
  String name(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    switch (this) {
      case DifficultyType.none:
        return "None";
      case DifficultyType.beginner:
        return localizations.difficultyTypeBeginner;
      case DifficultyType.intermediate:
        return localizations.difficultyTypeIntermediate;
      case DifficultyType.advanced:
        return localizations.difficultyTypeAdvanced;
      default:
        return "";
    }
  }

  /* DifficultyType difficultyTypeFromString(String name, BuildContext context) {
    final localizations = AppLocalizations.of(context);
    switch (name) {
      case "None":
        return DifficultyType.none;
      case localizations.difficultyTypeBeginner:
        return DifficultyType.beginner;
      case "Intermediate":
        return DifficultyType.intermediate;
      case "Advanced":
        return DifficultyType.advanced;
      default:
        return DifficultyType.none;
    }
  } */
}