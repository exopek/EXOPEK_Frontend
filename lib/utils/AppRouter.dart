import 'package:exopek_workout_app/presentation/Dicover.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/Coach.dart';
import '../presentation/Profile.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: "/discover",
    navigatorKey: GlobalKey<NavigatorState>(),
    routes: [
      GoRoute(
        path: "/coach",
        builder: (context, state) => const Coach(),
      ),
      GoRoute(
        path: "/discover",
        builder: (context, state) => const Discover(),
      ),
      GoRoute(
        path: "/profile",
        builder: (context, state) => const Profile(),
      ),
    ],
  );

  static void goToCoach() {
    router.go("/coach");
  }

  static void goToDiscover() {
    router.go("/discover");
  }

  static void goToProfile() {
    router.go("/profile");
  }
}
