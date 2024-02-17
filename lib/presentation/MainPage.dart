import 'package:exopek_workout_app/components/NavigationBarCustom.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/presentation/Coach/Coach.dart';
import 'package:exopek_workout_app/presentation/Discover/Dicover.dart';
import 'package:exopek_workout_app/presentation/Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Discover/DiscoverPage.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    final currentRouteIndex = ref.watch(selectedNavigationBarIndexProvider);
    return Scaffold(
      backgroundColor: Color(0xFF0C0C0C),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            if (currentRouteIndex == 0)
              Expanded(
                  child: Coach())
            /* Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.red,
              ) */
            else if (currentRouteIndex == 1)
              Expanded(
                  child: DiscoverPage())
            else if (currentRouteIndex == 2)
              Expanded(
                  child: Profile()),
            NavigationBarCustom(),
          ],
        ),
      ),
    );
  }
}
