import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum PhaseType {
  phase1,
  phase2,
  phase3,
  phase4,
  phase5,
  phase6,
  phase7,
  phase8,
}

extension PhaseTypeExtension on PhaseType {
  String name(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    switch (this) {
      case PhaseType.phase1:
        return "${localizations.planDetailsPageSubTitleDetails} 1";
      case PhaseType.phase2:
        return "${localizations.difficultyTypeBeginner} 2";
      case PhaseType.phase3:
        return "${localizations.difficultyTypeIntermediate} 3";
      case PhaseType.phase4:
        return "${localizations.difficultyTypeAdvanced} 4";
      case PhaseType.phase5:
        return "${localizations.difficultyTypeAdvanced} 5";
      case PhaseType.phase6:
        return "${localizations.difficultyTypeAdvanced} 6";
      case PhaseType.phase7:
        return "${localizations.difficultyTypeAdvanced} 7";
      case PhaseType.phase8:
        return "${localizations.difficultyTypeAdvanced} 8";      
      default:
        return "";
    }
  }
}