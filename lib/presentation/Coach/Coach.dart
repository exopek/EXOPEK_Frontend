import 'dart:async';

import 'package:exopek_workout_app/components/AreaSelection.dart';
import 'package:exopek_workout_app/components/BookmarkEmpty.dart';
import 'package:exopek_workout_app/components/CurvedHeader.dart';
import 'package:exopek_workout_app/components/NavigationBarCustom.dart';
import 'package:exopek_workout_app/components/PlanCardHorizontal.dart';
import 'package:exopek_workout_app/components/PlanProgressCard.dart';
import 'package:exopek_workout_app/components/WorkoutLists/WorkoutCardHorizontal.dart';
import 'package:exopek_workout_app/dependencyInjection/plansProvider/PlansProvider.dart';
import 'package:exopek_workout_app/dependencyInjection/userProvider/UserProvider.dart';
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

class Coach extends ConsumerStatefulWidget {
  const Coach({super.key});

  @override
  ConsumerState<Coach> createState() => _CoachState();
}

class _CoachState extends ConsumerState<Coach> {
  late ScrollController _scrollController;
  late List<String> _selectedAreas;
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
    _selectedAreas = [
      "Beliebte Workouts",
      "Neue Pläne",
      "Favorieten",
      "Neue Workouts"
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
    return Scaffold(
      backgroundColor: Color(0xFF0C0C0C),
      body: coachControllerProvider.when(
        data: (data) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      children: [
                        // Header
                        Container(
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
                                  icon: Icon(
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
                                        shape: OvalBorder(
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
                                      decoration: ShapeDecoration(
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
                                    '${user!.firstname} ${user.lastname}',
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
                            padding: EdgeInsets.only(
                              top: 21,
                              left: 16,
                            ),
                            child: Text(
                              'Sammlungen',
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
                                          AppRouter.goToWorkouts();
                                        if (index == 1) AppRouter.goToPlans();
                                        if (index == 2)
                                          AppRouter.goToLikedWorkouts();
                                      },
                                      child: AreaSelection(
                                          label: _selectedAreas[index],
                                          assetPath:
                                              "assets/images/testImage.jpeg"),
                                    );
                                  }),
                            )),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 16,
                              top: 16,
                            ),
                            child: Text(
                              data.startedPlans.isEmpty
                                  ? 'Starte hier'
                                  : 'Dein aktueller Plan',
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
                              height: 176,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.startedPlans.isEmpty
                                      ? 1
                                      : data.startedPlans.length,
                                  itemBuilder: (context, index) {
                                    if (data.startedPlans.isEmpty) {
                                      return TextButton(
                                        onPressed: () {
                                          ref
                                                  .read(selectedPlanIdProvider
                                                      .notifier)
                                                  .state =
                                              "70ed1ea3-6ebd-4b3d-8554-7432eef60ade";
                                          AppRouter.goToPlanDetail();
                                        },
                                        style: ButtonStyle(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                        ),
                                        child: PlanProgressWithImageCard(
                                            planStatus: new PlanStatus(
                                                id: "",
                                                currentPhase: 0,
                                                status: 0,
                                                workoutIds: [],
                                                progressPercentage: 0,
                                                planId: "",
                                                createdAt:
                                                    DateTime.now().toString()),
                                            plan: PlanListItem(
                                              id: "",
                                              name: "Stability Plan",
                                              hashtags:
                                                  "Full Body,Strenght,Hypertrophy,Upper Body",
                                              previewImageUrl:
                                                  "https://exopekblob.blob.core.windows.net/images/Combat Force_0025_IMG_2630.jpg.jpg",
                                              duration: 4,
                                              videoUrl: "",
                                            )),
                                      );
                                    } else {
                                      return TextButton(
                                          onPressed: () {
                                            ref
                                                    .read(selectedPlanIdProvider
                                                        .notifier)
                                                    .state =
                                                data.startedPlans[index].id;
                                            AppRouter
                                                .goToPlanPhaseWithLastRoute();
                                          },
                                          style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                          ),
                                          child: PlanProgressWithImageCard(
                                              planStatus: data.planStatuses
                                                  .firstWhere((element) =>
                                                      element.planId ==
                                                      data.startedPlans[index]
                                                          .id),
                                              plan: data.startedPlans[index]));
                                    }
                                  }),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Workouts',
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
                                child: Text('mehr anzeigen',
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
                            padding: EdgeInsets.only(left: 0, top: 12),
                            child: Container(
                              height: 130,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.workouts.length,
                                  itemBuilder: (context, index) {
                                    return TextButton(
                                      onPressed: () {
                                        ref
                                            .read(selectedWorkoutIdProvider
                                                .notifier)
                                            .state = data.workouts[index].id;
                                        AppRouter.goToWorkoutDetail();
                                      },
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                      ),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: WorkoutCardHorizontal(
                                            workout: data.workouts[index]),
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
                              Text('Pläne',
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
                                  AppRouter.goToPlans();
                                },
                                child: Text('mehr anzeigen',
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
                            padding: EdgeInsets.only(left: 0, top: 12),
                            child: Container(
                              height: 220,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.plans.length,
                                  itemBuilder: (context, index) {
                                    return TextButton(
                                      onPressed: () {
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
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                      ),
                                      child: PlanCardHorizontal(
                                          planListItem: data.plans[index],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8),
                                    );
                                  }),
                            )),
                        /* Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 21,
                                  left: 16,
                                ),
                                child: Text(
                                  'Bookmarked Workouts',
                                  style: TextStyle(
                                    color: Color(0xFF838282),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 16, top: 21),
                                child: Container(
                                  height: 220,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      controller: _scrollController,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 1,
                                      itemBuilder: (context, index) {
                                        return BookmarkEmpty();
                                      }),
                                )), */
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
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
                            color: Color(0xFF0C0C0C),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.7),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                            border: Border.all(
                              color: Color(0xFF262424),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: Icon(
                                    Icons.filter_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    'Filter',
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
        loading: () => Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              strokeWidth: 0.5,
              color: ThemeBase.of(context).secondary,
            )),
        error: (error, stackTrace) => Text(error.toString()),
      ),
    );
  }
}
