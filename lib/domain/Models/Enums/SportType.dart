import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum SportType {
    None,
    Running,
    Cycling,
    Swimming,
    Walking,
    Hiking,
    Yoga,
    Pilates,
    Gym,
    Crossfit,
    Football,
    Basketball,
    Volleyball,
    Tennis,
    TableTennis,
    Badminton,
    Fitness,
    Boxing,
    MartialArts,
    Dance,
    AmericanFootball,
    Baseball,
    Rugby,
    MuayThai,
    KickBoxing,
    Judo,
    Karate,
    Taekwondo,
}

extension SportTypeExtension on SportType {
  String name(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    switch (this) {
      case SportType.None:
        return localizations!.sportTypeNone;
      case SportType.Running:
        return localizations.sportTypeRunning;
      case SportType.Cycling:
        return localizations.sportTypeCycling;
      case SportType.Swimming:
        return localizations.sportTypeSwimming;
      case SportType.Walking:
        return localizations.sportTypeWalking;
      case SportType.Hiking:
        return localizations.sportTypeHiking;
      case SportType.Yoga:
        return localizations.sportTypeYoga;
      case SportType.Pilates:
        return localizations.sportTypePilates;
      case SportType.Gym:
        return localizations.sportTypeGym;
      case SportType.Crossfit:
        return localizations.sportTypeCrossfit;
      case SportType.Football:
        return localizations.sportTypeFootball;
      case SportType.Basketball:
        return localizations.sportTypeBasketball;
      case SportType.Volleyball:
        return localizations.sportTypeVolleyball;
      case SportType.Tennis:
        return localizations.sportTypeTennis;
      case SportType.TableTennis:
        return localizations.sportTypeTableTennis;
      case SportType.Badminton:
        return localizations.sportTypeBadminton;
      case SportType.Fitness:
        return localizations.sportTypeFitness;
      case SportType.Boxing:
        return localizations.sportTypeBoxing;
      case SportType.MartialArts:
        return localizations.sportTypeMartialArts;
      case SportType.Dance:
        return localizations.sportTypeDance;
      case SportType.AmericanFootball:
        return localizations.sportTypeAmericanFootball;
      case SportType.Baseball:
        return localizations.sportTypeBaseball;
      case SportType.Rugby:
        return localizations.sportTypeRugby;
      case SportType.MuayThai:
        return localizations.sportTypeMuayThai;
      case SportType.KickBoxing:
        return localizations.sportTypeKickBoxing;
      case SportType.Judo:
        return localizations.sportTypeJudo;
      case SportType.Karate:
        return localizations.sportTypeKarate;
      case SportType.Taekwondo:
        return localizations.sportTypeTaekwondo;
      default:
        return '';
    }
  }
}

