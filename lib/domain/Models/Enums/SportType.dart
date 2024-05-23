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
    String get name {
        switch (this) {
            case SportType.None:
                return 'Keine Angabe';
            case SportType.Running:
                return 'Laufen';
            case SportType.Cycling:
                return 'Radfahren';
            case SportType.Swimming:
                return 'Schwimmen';
            case SportType.Walking:
                return 'Spazieren';
            case SportType.Hiking:
                return 'Wandern';
            case SportType.Yoga:
                return 'Yoga';
            case SportType.Pilates:
                return 'Pilates';
            case SportType.Gym:
                return 'Fitnessstudio';
            case SportType.Crossfit:
                return 'Crossfit';
            case SportType.Football:
                return 'Fußball';
            case SportType.Basketball:
                return 'Basketball';
            case SportType.Volleyball:
                return 'Volleyball';
            case SportType.Tennis:
                return 'Tennis';
            case SportType.TableTennis:
                return 'Tischtennis';
            case SportType.Badminton:
                return 'Badminton';
            case SportType.Fitness:
                return 'Fitness';
            case SportType.Boxing:
                return 'Boxen';
            case SportType.MartialArts:
                return 'MartialArts';
            case SportType.Dance:
                return 'Tanz';
            case SportType.AmericanFootball:
                return 'AmericanFootball';
            case SportType.Baseball:
                return 'Baseball';
            case SportType.Rugby:
                return 'Rugby';
            case SportType.MuayThai:
                return 'MuayThai';
            case SportType.KickBoxing:
                return 'KickBoxen';
            case SportType.Judo:
                return 'Judo';
            case SportType.Karate:
                return 'Karate';
            case SportType.Taekwondo:
                return 'Taekwondo';
        }
    }
}

