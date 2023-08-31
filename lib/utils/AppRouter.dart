import 'package:exopek_workout_app/presentation/Dicover.dart';
import 'package:exopek_workout_app/presentation/MainPage.dart';
import 'package:exopek_workout_app/presentation/WorkoutDetail.dart';
import 'package:exopek_workout_app/presentation/Workouts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/Coach.dart';
import '../presentation/Profile.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: "/",
    navigatorKey: GlobalKey<NavigatorState>(),
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: "/workouts",
        builder: (context, state) => const Workouts(),
      ),
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
      GoRoute(
          path: "/workoutDetails",
          builder: (context, state) {
            return WorkoutDetail();
          }),
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

  static void goToWorkouts() {
    router.push("/workouts");
  }

  static void goToWorkoutDetail() {
    router.push("/workoutDetails");
  }
}
