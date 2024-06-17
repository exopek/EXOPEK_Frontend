import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

enum TrainingFrequencyType {
  None,
  Irregular,
  Regular,
  Athlet,
  ProfiAthlet
}

extension TrainingFrequencyTypeExtension on TrainingFrequencyType {
  String name(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    switch (this) {
      case TrainingFrequencyType.None:
        return localizations.trainingFrequencyNone;
      case TrainingFrequencyType.Irregular:
        return localizations.trainingFrequencyIrregular;
      case TrainingFrequencyType.Regular:
        return localizations.trainingFrequencyRegular;
      case TrainingFrequencyType.Athlet:
        return localizations.trainingFrequencyAthlete;
      case TrainingFrequencyType.ProfiAthlet:
        return localizations.trainingFrequencyProAthlete;
      default:
        return localizations.trainingFrequencyNone;
    }
  }
}