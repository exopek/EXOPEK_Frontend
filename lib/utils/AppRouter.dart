import 'package:exopek_workout_app/domain/Models/Exercise.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/presentation/Dicover.dart';
import 'package:exopek_workout_app/presentation/LoopVideos/LoopVideos.dart';
import 'package:exopek_workout_app/presentation/MainPage.dart';
import 'package:exopek_workout_app/presentation/WorkoutDetail.dart';
import 'package:exopek_workout_app/presentation/Workouts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/Coach.dart';
import '../presentation/Plan/PlanDetailPage.dart';
import '../presentation/Plan_Phase/PlanPhasePage.dart';
import '../presentation/Plans/PlansPage.dart';
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
        path: "/plans",
        builder: (context, state) => const PlansPage(),
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
      GoRoute(
          path: "/planDetails",
          builder: (context, state) {
            return PlanDetailPage();
          }),
      GoRoute(
          path: "/planPhase",
          builder: (context, state) {
            return PlanPhasePage(
                workoutPlanConfig: state.extra as List<WorkoutPlanConfig>);
          }),
      GoRoute(
          path: "/videoLoops",
          builder: (context, state) {
            //final workoutConfig = state./* queryParams['workoutConfig']; */
            return LoopVideos(workoutDetails: state.extra as WorkoutDetails);
          }),
    ],
  );

  static void goToCoach() {
    router.go("/coach");
  }

  static void goToDiscover() {
    router.go("/discover");
  }

  static void goToMainPage() {
    router.go("/");
  }

  static void goToProfile() {
    router.go("/profile");
  }

  static void goToWorkouts() {
    router.push("/workouts");
  }

  static void goToPlans() {
    router.push("/plans");
  }

  static void goToPlanPhase(List<WorkoutPlanConfig> workoutPlanConfig) {
    router.push("/planPhase", extra: workoutPlanConfig);
  }

  static void goToWorkoutDetail() {
    router.push("/workoutDetails");
  }

  static void goToPlanDetail() {
    router.push("/planDetails");
  }

  static void goToVideoLoops(WorkoutDetails workoutConfig) {
    router.push("/videoLoops", extra: workoutConfig);
  }
}
