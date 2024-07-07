import 'dart:async';
import 'package:exopek_workout_app/components/AreaSelection.dart';
import 'package:exopek_workout_app/components/CurvedHeader.dart';
import 'package:exopek_workout_app/components/PlanCardHorizontal.dart';
import 'package:exopek_workout_app/components/WorkoutLists/WorkoutCardHorizontal.dart';
import 'package:exopek_workout_app/dependencyInjection/plansProvider/PlansProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/workoutProvider/WorkoutProvider.dart';
import 'package:exopek_workout_app/domain/Models/Enums/DifficultyType.dart';
import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/PlanProgressWithImageCard.dart';
import '../../data/AppStateProvider.dart';
import '../../dependencyInjection/coachProvider/coachPageControllerProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Coach extends ConsumerStatefulWidget {
  const Coach({super.key});

  @override
  ConsumerState<Coach> createState() => _CoachState();
}

class _CoachState extends ConsumerState<Coach> {
  late ScrollController _scrollController;
  late List<String> _selectedAreas;
  late List<String> _assets;
  /* late ui.Image image; */

  Future<ui.Image> loadImage(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    final List<int> bytes = data.buffer.asUint8List();
    final Completer<ui.Image> completer = Completer();

    ui.decodeImageFromList(Uint8List.fromList(bytes), (ui.Image img) {
      completer.complete(img);
    });

    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    
    _assets = [
      "assets/images/HighKnees.jpg",
      "assets/images/LungeBoxing.jpg",
      "assets/images/HighKneesBoxingFortgeschritten.jpg",
      "assets/images/ShoulderPress.jpg"
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final coachControllerProvider = ref.watch(asyncCoachPageControllerProvider);
    final user = ref.watch(userStateProvider);
    _selectedAreas = [
      AppLocalizations.of(context).coachPageHighlights1,
      AppLocalizations.of(context).coachPageHighlights2,
      AppLocalizations.of(context).coachPageHighlights3,
      AppLocalizations.of(context).coachPageHighlights4,
    ];
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: ThemeBase.of(context).primaryBackground,
        body: coachControllerProvider.when(
          data: (data) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        children: [
                          // Header
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 168,
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 0,
                                    left: 0,
                                    child: SizedBox(
                                      height: 300,
                                      width: MediaQuery.of(context).size.width,
                                      child: CustomPaint(
                                        painter: CurveHeader(
                                            color: Colors.blueGrey, image: null),
                                      ),
                                    )),
                                Positioned(
                                  right: 16,
                                  top: 57,
                                  child: IconButton(
                                    onPressed: () {
                                      AppRouter.goToSideBar();
                                    },
                                    icon: const Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  top: 100,
                                  child: Builder(builder: (context) {
                                    if (user!.imageUrl != null) {
                                      return Container(
                                        width: 65,
                                        height: 65,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(user
                                                .imageUrl!), // "https://via.placeholder.com/65x65"
                                            fit: BoxFit.cover,
                                          ),
                                          shape: const OvalBorder(
                                            side: BorderSide(
                                                width: 1,
                                                color: Color(0xFF262424)),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        width: 65,
                                        height: 65,
                                        decoration: const ShapeDecoration(
                                          shape: OvalBorder(
                                            side: BorderSide(
                                                width: 1,
                                                color: Color(0xFF262424)),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${user.firstname[0]}${user.lastname[0]}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                                ),
                                Positioned(
                                  left: 86,
                                  top: 117,
                                  child: SizedBox(
                                    child: Text(
                                      '${user!.username}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 86,
                                  top: 137,
                                  child: Text(
                                    'EXOPEK Athlet',
                                    style: TextStyle(
                                      color: Color(0xFF838282),
                                      fontSize: 10,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Body
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 21,
                                left: 16,
                              ),
                              child: Text(
                                AppLocalizations.of(context).coachPageHighlightsTitle,
                                style: ThemeBase.of(context)
                                    .headlineSmall
                                    .copyWith(
                                      height: 0,
                                      fontSize: 20,
                                      color: ThemeBase.of(context).primaryText,
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 0, top: 12),
                              child: Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    controller: _scrollController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return TextButton(
                                        onPressed: () {
                                          if (index == 0) 
                                          {
                                            ref.read(selectedWorkoutQueryProvider.notifier).state = {
                                                "bestRated": "true",
                                            };
                                            AppRouter.goToHighlightsWorkouts();
                                          }
                                          if (index == 1)
                                          {
                                            ref.read(selectedPlanQueryProvider.notifier).state = {
                                                "isNew": "true",
                                              };
                                              AppRouter.goToHighlightPlans();
                                          } 
                                          if (index == 2) AppRouter.goToLikedWorkouts();
                                          if (index == 3) 
                                          {
                                            ref.read(selectedWorkoutQueryProvider.notifier).state = {
                                                "isNew": "true",
                                            };
                                            AppRouter.goToHighlightsWorkouts();
                                          }
                                        },
                                        child: AreaSelection(
                                            label: _selectedAreas[index],
                                            assetPath:
                                                _assets[index]),
                                      );
                                    }),
                              )),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 16,
                              ),
                              child: Text(
                                data.startedPlans.isEmpty
                                    ? AppLocalizations.of(context).coachPageStartedPlansTitle1
                                    : AppLocalizations.of(context).coachPageStartedPlansTitle2,
                                style: ThemeBase.of(context)
                                    .headlineSmall
                                    .copyWith(
                                      height: 0,
                                      fontSize: 20,
                                      color: ThemeBase.of(context).primaryText,
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 16.0, top: 12),
                              child: SizedBox(
                                height: 156,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    controller: _scrollController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.startedPlans.isEmpty
                                        ? 1
                                        : data.startedPlans.length,
                                    itemBuilder: (context, index) {
                                      if (data.startedPlans.isEmpty) {
                                        return GestureDetector(
                                          onTap: () {
                                            ref
                                                    .read(selectedPlanIdProvider
                                                        .notifier)
                                                    .state =
                                                "70ed1ea3-6ebd-4b3d-8554-7432eef60ade";
                                            AppRouter.goToPlanDetail();
                                          },
                                          
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 16.0),
                                            child: SizedBox(
                                              width: MediaQuery.sizeOf(context).width *
                                                  0.8,
                                              child: PlanProgressWithImageCard(
                                                  planStatus: PlanStatus(
                                                      id: "",
                                                      currentPhase: 0,
                                                      status: 0,
                                                      workoutIds: [],
                                                      progressPercentage: 0,
                                                      planId: "",
                                                      createdAt:
                                                          DateTime.now().toString().split(" ")[0]),
                                                  plan: PlanListItem(
                                                    id: "",
                                                    name: "EXOPEK Starter",
                                                    hashtags:
                                                        "Full Body,Strenght,Hypertrophy,Upper Body",
                                                    previewImageUrl:
                                                        "https://exopekblob.blob.core.windows.net/basic/FacePull.jpg",
                                                    duration: 4,
                                                    videoUrl: "",
                                                  )),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                            onTap: () {
                                              ref
                                                      .read(selectedPlanIdProvider
                                                          .notifier)
                                                      .state =
                                                  data.startedPlans[index].id;
                                              AppRouter
                                                  .goToPlanPhaseWithLastRoute();
                                            },
                                            
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 16.0),
                                              child: SizedBox(
                                                width: MediaQuery.sizeOf(context)
                                                        .width *
                                                    0.8,
                                                child: PlanProgressWithImageCard(
                                                    planStatus: data.planStatuses
                                                        .firstWhere((element) =>
                                                            element.planId ==
                                                            data.startedPlans[index]
                                                                .id),
                                                    plan: data.startedPlans[index]),
                                              ),
                                            ));
                                      }
                                    }),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 16.0, right: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocalizations.of(context).coachPageWorkoutsTitle,
                                    style: ThemeBase.of(context)
                                        .headlineSmall
                                        .copyWith(
                                          height: 0,
                                          fontSize: 20,
                                          color:
                                              ThemeBase.of(context).primaryText,
                                        )),
                                GestureDetector(
                                  onTap: () {
                                    AppRouter.goToWorkouts();
                                  },
                                  child: Text(AppLocalizations.of(context).coachPageShowMoreButton,
                                      style: ThemeBase.of(context)
                                          .headlineSmall
                                          .copyWith(
                                              fontSize: 16,
                                              color: ThemeBase.of(context)
                                                  .secondaryText,
                                              height: 0)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 16.0, top: 12),
                              child: SizedBox(
                                height: 105,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    controller: _scrollController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.workouts.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(selectedWorkoutIdProvider
                                                  .notifier)
                                              .state = data.workouts[index].id;
                                              Map<String, String> querys = {
                                        "id": data.workouts[index].id.toString(),
                                        "difficultyType":
                                            DifficultyType.beginner.index.toString()
                                      };
                                      ref.read(selectedWorkoutQueryProvider.notifier).state = querys;
                                          AppRouter.goToWorkoutDetail();
                                        },
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 16.0),
                                          child: SizedBox(
                                            width:
                                                MediaQuery.of(context).size.width *
                                                    0.8,
                                            child: WorkoutCardHorizontal(
                                                workout: data.workouts[index]),
                                          ),
                                        ),
                                      );
                                    }),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocalizations.of(context).coachPagePlansTitle,
                                    style: ThemeBase.of(context)
                                        .headlineSmall
                                        .copyWith(
                                          height: 0,
                                        )),
                                GestureDetector(
                                  onTap: () {
                                    AppRouter.goToPlans();
                                  },
                                  child: Text(AppLocalizations.of(context).coachPageShowMoreButton,
                                      style: ThemeBase.of(context)
                                          .headlineSmall
                                          .copyWith(
                                              fontSize: 16,
                                              color: ThemeBase.of(context)
                                                  .secondaryText,
                                              height: 0)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 16.0, top: 12),
                              child: SizedBox(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    controller: _scrollController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.plans.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (!data.startedPlans.isEmpty &&
                                              data.startedPlans.any((element) =>
                                                  element.id ==
                                                  data.plans[index].id)) {
                                            ref
                                                .read(selectedPlanIdProvider
                                                    .notifier)
                                                .state = data.plans[index].id;
                                            AppRouter
                                                .goToPlanPhaseWithLastRoute();
                                          } else {
                                            ref
                                                .read(selectedPlanIdProvider
                                                    .notifier)
                                                .state = data.plans[index].id;
                                            AppRouter.goToPlanDetail();
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 16.0),
                                          child: PlanCardHorizontal(
                                              planListItem: data.plans[index],
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8),
                                        ),
                                      );
                                    }),
                              )),
                              const SizedBox(height: 64),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 44.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                          onPressed: () {
                            AppRouter.goToDiscoverFilter();
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0C0C0C),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.7),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                              border: Border.all(
                                color: const Color(0xFF262424),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 0.0),
                                    child: Icon(
                                      Icons.filter_alt_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      AppLocalizations.of(context).coachPageFilterButton,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            );
          },
          loading: () => const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 0.5,
                color: Colors.white,
              )),
          error: (error, stackTrace) => Text(error.toString()),
        ),
      ),
    );
  }
}
