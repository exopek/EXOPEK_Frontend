import 'package:exopek_workout_app/components/Navigation/DashboardSideMenu.dart';
import 'package:exopek_workout_app/domain/Models/Exercise.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/LoopVideosPageViewModel.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/WorkoutSummaryPageViewModel.dart';
import 'package:exopek_workout_app/presentation/Comments/CommentsPage.dart';
import 'package:exopek_workout_app/presentation/Discover/Dicover.dart';
import 'package:exopek_workout_app/presentation/Discover/DiscoverFilterPage.dart';
import 'package:exopek_workout_app/presentation/LoopVideos/LoopVideos.dart';
import 'package:exopek_workout_app/presentation/LoopVideos/PreTimerPage.dart';
import 'package:exopek_workout_app/presentation/MainPage.dart';
import 'package:exopek_workout_app/presentation/ProfilEdit/ProfilEditPage.dart';
import 'package:exopek_workout_app/presentation/Settings/Settings.dart';
import 'package:exopek_workout_app/presentation/WorkoutDetail.dart';
import 'package:exopek_workout_app/presentation/Workouts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../domain/Models/Plan.dart';
import '../domain/Models/ViewModels/WorkoutDetailPageViewModel.dart';
import '../presentation/Coach/Coach.dart';
import '../presentation/Authentication/Login.dart';
import '../presentation/OnBoarding/OnBoarding_1.dart';
import '../presentation/OnBoarding/OnBoarding_2.dart';
import '../presentation/OnBoarding/OnBoarding_3.dart';
import '../presentation/OnBoarding/OnBoarding_4.dart';
import '../presentation/OnBoarding/OnBoarding_5.dart';
import '../presentation/OnBoarding/OnBoarding_6.dart';
import '../presentation/OnBoarding/Onboarding_0.dart';
import '../presentation/Plan/FadeInTransitionScreen.dart';
import '../presentation/Plan/PlanDetailPage.dart';
import '../presentation/Plan_Phase/PlanPhasePage.dart';
import '../presentation/Plans/PlansPage.dart';
import '../presentation/Profil/Profile.dart';
import '../presentation/WorkoutSummary/WorkoutSummaryPage.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: "/onBoarding0",
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
            return WorkoutDetail(
                viewModel: state.extra as WorkoutDetailPageViewModel?);
          }),
      GoRoute(
          path: "/planDetails",
          builder: (context, state) {
            return PlanDetailPage();
          }),
      GoRoute(
          path: "/discoverFilter",
          builder: (context, state) {
            return DiscoverFilterPage();
          }),
      GoRoute(
          path: "/planPhase",
          builder: (context, state) {
            /* return PlanPhasePage(planPhase: state.extra as PlanPhase); */
            return PlanPhasePage();
          }),
      GoRoute(
          path: "/planTransition",
          builder: (context, state) {
            return FadeInTransitionScreen();
          }),
      GoRoute(
          path: "/videoLoops",
          builder: (context, state) {
            //final workoutConfig = state./* queryParams['workoutConfig']; */
            return LoopVideos(
                viewModel: state.extra as LoopVideosPageViewModel);
          }),
      GoRoute(
          path: "/preTimer",
          builder: (context, state) {
            //final workoutConfig = state./* queryParams['workoutConfig']; */
            return PreTimerPage(
                viewModel: state.extra as LoopVideosPageViewModel);
          }),
      GoRoute(
          path: "/workoutSummary",
          builder: (context, state) {
            /* return PlanPhasePage(planPhase: state.extra as PlanPhase); */
            return WorkoutSummaryPage(
              viewModel: state.extra as WorkoutSummaryPageViewModel,
            );
          }),
      GoRoute(
          path: "/onBoarding0",
          builder: (context, state) {
            /* return PlanPhasePage(planPhase: state.extra as PlanPhase); */
            return OnBoarding0();
          }),
      GoRoute(
          path: "/onBoarding1",
          builder: (context, state) {
            /* return PlanPhasePage(planPhase: state.extra as PlanPhase); */
            return OnBoarding1();
          }),
      GoRoute(
          path: "/onBoarding2",
          builder: (context, state) {
            /* return PlanPhasePage(planPhase: state.extra as PlanPhase); */
            return OnBoarding2();
          }),
      GoRoute(
          path: "/onBoarding3",
          builder: (context, state) {
            /* return PlanPhasePage(planPhase: state.extra as PlanPhase); */
            return OnBoarding3();
          }),
      GoRoute(
          path: "/onBoarding4",
          builder: (context, state) {
            /* return PlanPhasePage(planPhase: state.extra as PlanPhase); */
            return OnBoarding4(
              userDto: state.extra as UpdateUserDto,
            );
          }),
      GoRoute(
          path: "/onBoarding5",
          builder: (context, state) {
            /* return PlanPhasePage(planPhase: state.extra as PlanPhase); */
            return OnBoarding5(
              userDto: state.extra as UpdateUserDto,
            );
          }),
      GoRoute(
          path: "/onBoarding6",
          builder: (context, state) {
            /* return PlanPhasePage(planPhase: state.extra as PlanPhase); */
            return OnBoarding6(
              userDto: state.extra as UpdateUserDto,
            );
          }),
      GoRoute(
          path: "/login",
          builder: (context, state) {
            /* return PlanPhasePage(planPhase: state.extra as PlanPhase); */
            return LoginPage();
          }),
      GoRoute(
          path: "/comments",
          builder: (context, state) {
            /* return PlanPhasePage(planPhase: state.extra as PlanPhase); */
            return CommentsPage();
          }),
      GoRoute(
          path: "/settings",
          builder: (context, state) {
            /* return PlanPhasePage(planPhase: state.extra as PlanPhase); */
            return SettingsPage(
              user: state.extra as User,
            );
          }),
      GoRoute(
          path: "/profilEdit",
          builder: (context, state) {
            /* return PlanPhasePage(planPhase: state.extra as PlanPhase); */
            return ProfilEditPage();
          }),
      GoRoute(
          path: "/sideBar",
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const DashboardSideMenu(0.8),
              opaque: false,
            barrierColor: Colors.black.withOpacity(0.5), // Hintergrundfarbe des Overlays
            barrierDismissible: true, // Klick auf Hintergrund schließt Overlay
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: const Offset(0, 0),
                  ).animate(animation),
                  child: child,
                );
              });
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
    router.push("/profile");
  }

  static void goToWorkouts() {
    router.push("/workouts");
  }

  static void goToPlans() {
    router.push("/plans");
  }

  static void goToPlansAndRemoveLastRoute() {
    router.pushReplacement("/plans");
  }

  static void goToPlanPhase() {
    router.pushReplacement("/planPhase");
  }

  static void goToPlanPhaseWithLastRoute() {
    router.push("/planPhase");
  }

  static void goToWorkoutDetail({WorkoutDetailPageViewModel? viewModel}) {
    router.push("/workoutDetails", extra: viewModel);
  }

  static void goToPlanDetail() {
    router.push("/planDetails");
  }

  static void goToDiscoverFilter() {
    router.push("/discoverFilter");
  }

  static void goToRegister() {
    router.push("/onBoarding1");
  }

  static void goToRegisterSucceed() {
    router.push("/onBoarding2");
  }

  static void goToOnBoarding3() {
    router.push("/onBoarding3");
  }

  static void goToOnBoarding4(UpdateUserDto updateUserDto) {
    router.push("/onBoarding4", extra: updateUserDto);
  }

  static void goToOnBoarding5(UpdateUserDto updateUserDto) {
    router.push("/onBoarding5", extra: updateUserDto);
  }

  static void goToOnBoarding6(UpdateUserDto updateUserDto) {
    router.push("/onBoarding6", extra: updateUserDto);
  }

  static void goToLogin() {
    router.push("/login");
  }

  static void goToVideoLoops(LoopVideosPageViewModel viewModel) {
    router.push("/videoLoops", extra: viewModel);
  }

  static void goToPreTimer(LoopVideosPageViewModel viewModel) {
    router.push("/preTimer", extra: viewModel);
  }

  static void goToPlanTransition() {
    router.pushReplacement("/planTransition");
  }

  static void goToWorkoutSummary(WorkoutSummaryPageViewModel viewModel) {
    router.push("/workoutSummary", extra: viewModel);
  }

  static void goToComments() {
    router.push("/comments");
  }

  static void goToSettings(User user) {
    router.push("/settings", extra: user);
  }

  static void goToProfilEdit() {
    router.push("/profilEdit");
  }

  static void goToSideBar() {
    router.push("/sideBar");
  }
}

class OverlayPageRoute extends PageRouteBuilder<void> {
  final WidgetBuilder builder;

  OverlayPageRoute({required this.builder})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get opaque => false;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);
}
