enum TrainingFrequencyType {
  None,
  Irregular,
  Regular,
  Athlet,
  ProfiAthlet
}

extension TrainingFrequencyTypeExtension on TrainingFrequencyType {
  String get name {
    switch (this) {
      case TrainingFrequencyType.None:
        return 'Keine Angabe';
      case TrainingFrequencyType.Irregular:
        return '0 - 1 Unregelmäßig';
      case TrainingFrequencyType.Regular:
        return '2 - 3 Regelmäßig';
      case TrainingFrequencyType.Athlet:
        return '4 - 5 Athlet';
      case TrainingFrequencyType.ProfiAthlet:
        return '6 - 7 Profi Athlet';
      default:
        return 'Keine Angabe';
    }
  }
}