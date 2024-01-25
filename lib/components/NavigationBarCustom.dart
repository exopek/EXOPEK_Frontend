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
      height: 50,
      decoration: BoxDecoration(color: Color(0xFF262323)),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 16,
            ),
            Container(
              height: 50,
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
            SizedBox(
              width: 24,
            ),
            SizedBox(
              height: 50,
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
            SizedBox(
              width: 24,
            ),
            SizedBox(
              height: 50,
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
            SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
