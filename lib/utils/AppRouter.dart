import 'package:exopek_workout_app/components/Navigation/DashboardSideMenu.dart';
import 'package:exopek_workout_app/domain/Models/Enums/SportType.dart';
import 'package:exopek_workout_app/domain/Models/Enums/TrainingFrequencyType.dart';
import 'package:exopek_workout_app/domain/Models/Exercise.dart';
import 'package:exopek_workout_app/domain/Models/User.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/LoopVideosPageViewModel.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/domain/Models/ViewModels/WorkoutSummaryPageViewModel.dart';
import 'package:exopek_workout_app/presentation/Comments/CommentsPage.dart';
import 'package:exopek_workout_app/presentation/Discover/Dicover.dart';
import 'package:exopek_workout_app/presentation/Discover/DiscoverFilterPage.dart';
import 'package:exopek_workout_app/presentation/ForgotPassword/ForgotPasswordPage.dart';
import 'package:exopek_workout_app/presentation/Workouts/HighlightsWorkoutsPage.dart';
import 'package:exopek_workout_app/presentation/LikedWorkouts/LikedWorkoutsPage.dart';
import 'package:exopek_workout_app/presentation/LoopVideos/LoopVideos.dart';
import 'package:exopek_workout_app/presentation/LoopVideos/PreTimerPage.dart';
import 'package:exopek_workout_app/presentation/MainPage.dart';
import 'package:exopek_workout_app/presentation/OnBoarding/OnBoarding_1_1.dart';
import 'package:exopek_workout_app/presentation/Plans/PlansPage.dart';
import 'package:exopek_workout_app/presentation/ProfilEdit/ProfilEditPage.dart';
import 'package:exopek_workout_app/presentation/ProfilEdit/SportTypeSelectionPage.dart';
import 'package:exopek_workout_app/presentation/ProfilEdit/TrainingFrequencySelectionPage.dart';
import 'package:exopek_workout_app/presentation/Settings/Settings.dart';
import 'package:exopek_workout_app/presentation/WorkoutDetails/WorkoutDetail.dart';
import 'package:exopek_workout_app/presentation/Workouts/Workouts.dart';
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
import '../presentation/Plans/HighlightsPlansPage.dart';
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
        path: "/highlightPlans",
        builder: (context, state) => const HighlightsPlansPage(),
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
            final extra = state.extra as Map<String, dynamic>?;
            final PlanStatus? planStatus = extra?['planStatus'] as PlanStatus?;
            final String? planWorkoutId = extra?['planWorkoutId'] as String?;
            return WorkoutDetail(
              planStatus: planStatus,
              planWorkoutId: planWorkoutId,
            );
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
            return LoopVideos(
                viewModel: state.extra as LoopVideosPageViewModel);
          }),
      GoRoute(
          path: "/preTimer",
          builder: (context, state) {
            return PreTimerPage(
                viewModel: state.extra as LoopVideosPageViewModel);
          }),
      GoRoute(
          path: "/workoutSummary",
          builder: (context, state) {
            return WorkoutSummaryPage(
              viewModel: state.extra as WorkoutSummaryPageViewModel,
            );
          }),
      GoRoute(
          path: "/onBoarding0",
          builder: (context, state) {
            return OnBoarding0();
          }),
      GoRoute(
          path: "/onBoarding1",
          builder: (context, state) {
            return OnBoarding1();
          }),
      GoRoute(
          path: "/onBoarding1_1",
          builder: (context, state) {
            return OnBoardingCode();
          }),
      GoRoute(
          path: "/onBoarding2",
          builder: (context, state) {
            return OnBoarding2();
          }),
      GoRoute(
          path: "/onBoarding3",
          builder: (context, state) {
            return OnBoarding3();
          }),
      GoRoute(
          path: "/onBoarding4",
          builder: (context, state) {
            return OnBoarding4(
              userDto: state.extra as UpdateUserDto,
            );
          }),
      GoRoute(
          path: "/onBoarding5",
          builder: (context, state) {
            return OnBoarding5(
              userDto: state.extra as UpdateUserDto,
            );
          }),
      GoRoute(
          path: "/onBoarding6",
          builder: (context, state) {
            return OnBoarding6(
              userDto: state.extra as UpdateUserDto,
            );
          }),
      GoRoute(
          path: "/login",
          builder: (context, state) {
            return LoginPage();
          }),
      GoRoute(
          path: "/comments",
          builder: (context, state) {
            return CommentsPage();
          }),
      GoRoute(
          path: "/settings",
          builder: (context, state) {
            return SettingsPage(
            );
          }),
      GoRoute(
          path: "/profilEdit",
          builder: (context, state) {
            return const ProfilEditPage();
          }),
      GoRoute(
          path: "/resetPassword",
          builder: (context, state) {
            return const ForgotPasswordPage();
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
      GoRoute(
          path: "/sportTypeSelection",
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            final Function(SportType) onSportTypeSelected =
                extra?['onSportTypeSelected'] as Function(SportType);
            final Map<dynamic, dynamic> selection = extra?['selection'] as Map<dynamic, dynamic>;
            return SportTypeSelectionPage(
              onSportTypeSelected: onSportTypeSelected,
              selection: selection,
            );
          }),
      GoRoute(
          path: "/trainingFrequencySelection",
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            final Function(TrainingFrequencyType) onTrainingFrequencySelected =
                extra?['onTrainingFrequencyTypeSelected'] as Function(TrainingFrequencyType);
            final Map<dynamic, dynamic> selection = extra?['selection'] as Map<dynamic, dynamic>;
            return TrainingFrequencySelectionPage(
              onTrainingFrequencyTypeSelected: onTrainingFrequencySelected,
              selection: selection,
            );
          }),
      GoRoute(
        path: "/likedWorkouts",
        builder: (context, state) => const LikedWorkoutsPage(),
      ),
      GoRoute(
          path: "/highlightWorkouts",
          builder: (context, state) {
            return const HighlightsWorkoutsPage();
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

  static void goToHighlightPlans() {
    router.push("/highlightPlans");
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

  static void goToWorkoutDetail({PlanStatus? planStatus, String? planWorkoutId}) {
    router.push("/workoutDetails", extra: {'planStatus': planStatus, 'planWorkoutId': planWorkoutId});
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

  static void goToConfirmEmail() {
    router.push("/onBoarding1_1");
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

  static void goToLoginAndRemoveLastRoute() {
    router.go("/login");
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

  static void goToSettings() {
    router.push("/settings");
  }

  static void goToProfilEdit() {
    router.push("/profilEdit");
  }

  static void goToSideBar() {
    router.push("/sideBar");
  }

  static void goToResetPassword() {
    router.push("/resetPassword");
  }

  static void goToOnBoarding0() {
    router.pushReplacement("/onBoarding0");
  }

  static void goToOnBoarding0AndRemoveLastRoute() {
    router.go("/onBoarding0");
  }

  static void goToSportTypeSelection(Function(SportType) onSportTypeSelected, Map<dynamic, dynamic> selection) {
    router.push("/sportTypeSelection", extra: {'onSportTypeSelected': onSportTypeSelected, 'selection': selection});
  }

  static void goToTrainingFrequencySelection(Function(TrainingFrequencyType) onTrainingFrequencySelected, Map<dynamic, dynamic> selection) {
    router.push("/trainingFrequencySelection", extra: {'onTrainingFrequencyTypeSelected': onTrainingFrequencySelected, 'selection': selection});
  }

  static void goToLikedWorkouts() {
    router.push("/likedWorkouts");
  }

  static void goToHighlightsWorkouts() {
    router.push("/highlightWorkouts");
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
