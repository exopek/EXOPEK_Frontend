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
        return "${localizations.planDetailsPageSubTitleDetails} 2";
      case PhaseType.phase3:
        return "${localizations.planDetailsPageSubTitleDetails} 3";
      case PhaseType.phase4:
        return "${localizations.planDetailsPageSubTitleDetails} 4";
      case PhaseType.phase5:
        return "${localizations.planDetailsPageSubTitleDetails} 5";
      case PhaseType.phase6:
        return "${localizations.planDetailsPageSubTitleDetails} 6";
      case PhaseType.phase7:
        return "${localizations.planDetailsPageSubTitleDetails} 7";
      case PhaseType.phase8:
        return "${localizations.planDetailsPageSubTitleDetails} 8";      
      default:
        return "";
    }
  }
}