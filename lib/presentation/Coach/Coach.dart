import 'dart:async';

import 'package:exopek_workout_app/components/AreaSelection.dart';
import 'package:exopek_workout_app/components/BookmarkEmpty.dart';
import 'package:exopek_workout_app/components/CurvedHeader.dart';
import 'package:exopek_workout_app/components/NavigationBarCustom.dart';
import 'package:exopek_workout_app/components/PlanCardHorizontal.dart';
import 'package:exopek_workout_app/components/PlanProgressCard.dart';
import 'package:exopek_workout_app/components/WorkoutLists/WorkoutCardHorizontal.dart';
import 'package:exopek_workout_app/dependencyInjection/plansProvider/PlansProvider.dart';
import 'package:exopek_workout_app/domain/Models/Plan.dart';
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
    _selectedAreas = ["Workouts", "Plans", "Coming Soon", "Coming Soon", "Coming Soon"];
    /* loadImage('assets/images/testImage.jpeg').then((value) => image = value); */
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final coachControllerProvider = ref.watch(asyncCoachPageControllerProvider);
    return Scaffold(
      backgroundColor: Color(0xFF0C0C0C),
      body: coachControllerProvider.when(
        data: (data) {
          return SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1.24,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
                    child: Column(
                      children: [
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
                                child: Container(
                                  width: 60,
                                  height: 33.68,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/app_launcher_icon.png"),
                                      invertColors: false,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 16,
                                top: 100,
                                child: Builder(
                                  builder: (context) {
                                    if (data.user.imageUrl != null) {
                                      return Container(
                                        width: 65,
                                        height: 65,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(data.user.imageUrl!), // "https://via.placeholder.com/65x65"
                                            fit: BoxFit.cover,
                                          ),
                                          shape: OvalBorder(
                                            side: BorderSide(
                                                width: 1, color: Color(0xFF262424)),
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
                                                width: 1, color: Color(0xFF262424)),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${data.user.firstname[0]}${data.user.lastname[0]}',
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
                                  }
                                ),
                              ),
                              Positioned(
                                left: 86,
                                top: 117,
                                child: SizedBox(
                                  child: Text(
                                    '${data.user.firstname} ${data.user.lastname}',
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 21,
                              left: 16,
                            ),
                            child: Text(
                              'Sammlungen',
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
                            padding: EdgeInsets.only(left: 0, top: 12),
                            child: Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return TextButton(
                                      onPressed: () {
                                        if (index == 0)
                                          AppRouter.goToWorkouts();
                                        if (index == 1) AppRouter.goToPlans();
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
                                                planId: ""),
                                            plan: PlanListItem(
                                                id: "",
                                                name: "Stability Plan",
                                                hashtags:
                                                    "Full Body,Strenght,Hypertrophy,Upper Body",
                                                previewImageUrl:
                                                    "https://exopekblob.blob.core.windows.net/images/Combat Force_0025_IMG_2630.jpg.jpg",
                                                duration: 4,
                                                videoUrl: "",)),
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 16,
                              left: 16,
                            ),
                            child: Text(
                              'New Workouts',
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 16,
                              left: 16,
                            ),
                            child: Text(
                              'Top Programs',
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
                                        if (!data.startedPlans.isEmpty && data.startedPlans.any((element) => element.id == data.plans[index].id)) {
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
                ],
              ));
        },
        loading: () => Align(
            alignment: Alignment.center, child: CircularProgressIndicator(strokeWidth: 1.0, color: Colors.black,)),
        error: (error, stackTrace) => Text(error.toString()),
      ),
    );
  }
}
