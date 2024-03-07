import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NavigationBarCustom extends ConsumerStatefulWidget {
  const NavigationBarCustom({super.key});

  @override
  ConsumerState<NavigationBarCustom> createState() =>
      _NavigationBarCustomState();
}

class _NavigationBarCustomState extends ConsumerState<NavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    final selectedNavigationBarCustomIndex =
        ref.watch(selectedNavigationBarIndexProvider);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height *  0.07,
      decoration: BoxDecoration(color: Color(0xFF212326)),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width * 0.333,
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
              child: IconButton(
                onPressed: () {
                  ref.read(selectedNavigationBarIndexProvider.notifier).state =
                      0;
                },
                icon: Icon(
                  Icons.home_filled,
                  color: selectedNavigationBarCustomIndex == 0
                      ? Colors.red
                      : Color(0xFFD9D9D9),
                  size: 24,
                ),
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
              height: 300,
              width: MediaQuery.of(context).size.width * 0.333,
              child: IconButton(
                onPressed: () {
                  ref.read(selectedNavigationBarIndexProvider.notifier).state =
                      1;
                },
                icon: Icon(
                  Icons.search,
                  color: selectedNavigationBarCustomIndex == 1
                      ? Colors.red
                      : Color(0xFFD9D9D9),
                  size: 24,
                ),
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
              height: 300,
              width: MediaQuery.of(context).size.width * 0.333,
              child: IconButton(
                onPressed: () {
                  ref.read(selectedNavigationBarIndexProvider.notifier).state =
                      2;
                },
                icon: Icon(
                  Icons.person_2_rounded,
                  color: selectedNavigationBarCustomIndex == 2
                      ? Colors.red
                      : Color(0xFFD9D9D9),
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
