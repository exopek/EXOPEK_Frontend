import 'package:exopek_workout_app/components/HashTagPill.dart';
import 'package:exopek_workout_app/components/PlanListCard.dart';
import 'package:exopek_workout_app/components/WorkoutLists/WorkoutCardHorizontal.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/presentation/Discover/DiscoverFilterPageController.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/BigHashTagPill.dart';
import '../../components/SearchBarCustom.dart';
import '../../data/AppStateProvider.dart';
import '../../dependencyInjection/discoveryProvider/discoveryFilterPageProvider.dart';
import '../../dependencyInjection/plansProvider/PlansProvider.dart';
import '../../utils/AppRouter.dart';

class DiscoverFilterPage extends ConsumerStatefulWidget {
  /* final FetchType fetchType;
  final String query; */
  const DiscoverFilterPage(/* this.fetchType, this.query,  */ {super.key});

  @override
  ConsumerState<DiscoverFilterPage> createState() => _DiscoverFilterPageState();
}

class _DiscoverFilterPageState extends ConsumerState<DiscoverFilterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late FocusNode _focusNode;
  late List<Map> _hashTagPillsName;
  late TextEditingController _searchController;
  late FetchType fetchType;
  late String query;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _focusNode = FocusNode();
    _searchController = TextEditingController();
    /* fetchType = widget.fetchType;
    query = widget.query; */
    _hashTagPillsName = [
      {"name": "Upper Body", "active": false},
      {"name": "Lower Body", "active": false},
      {"name": "Core", "active": false},
      {"name": "Cardio", "active": false},
      {"name": "Full Body", "active": false},
      {"name": "Yoga", "active": false},
      {"name": "Pilates", "active": false},
      {"name": "Stretching", "active": false},
      {"name": "Meditation", "active": false},
      {"name": "HIIT", "active": false},
      {"name": "Strength", "active": false},
      {"name": "Endurance", "active": false},
      {"name": "Weight Loss", "active": false},
      {"name": "Weight Gain", "active": false},
      {"name": "Body Building", "active": false},
      {"name": "Body Weight", "active": false},
      {"name": "Resistance", "active": false},
      {"name": "Calisthenics", "active": false},
      {"name": "Crossfit", "active": false},
      {"name": "Circuit Training", "active": false},
      {"name": "Tabata", "active": false},
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final discoverControllerProvider =
        ref.watch(asyncDiscoverFilterPageController);
    query = ref.watch(queryProvider);
    fetchType = ref.watch(fetchStateProvider);
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 210,
            decoration: BoxDecoration(color: Color(0xFF212326)),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                            onTap: () {
                              ref.read(queryProvider.notifier).state = "";
                              ref.read(fetchStateProvider.notifier).state =
                                  FetchType.none;
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xFFD9D9D9),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 52.0),
                        child: Text(
                          "Filter",
                          textAlign: TextAlign.center,
                          style: ThemeBase.of(context).titleMedium,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: SearchBarCustom(
                    xsize: 0.92,
                    hint: "Search",
                    controller: _searchController,
                    focusNode: _focusNode,
                    onClear: () {
                      ref.read(queryProvider.notifier).state = "";
                      _searchController.clear();
                      setState(() {
                        _focusNode.unfocus();
                        _hashTagPillsName.forEach((element) {
                          element["active"] = false;
                        });
                      });
                    },
                    /* onChanged: (value) {
                      if (value.isEmpty) {
                        ref.read(queryProvider.notifier).state = "";
                      }
                    }, */
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 12.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          ref.read(fetchStateProvider.notifier).state =
                              FetchType.workout;
                        },
                        child: BigHashTagPill(
                          text: "WORKOUTS",
                          color: fetchType == FetchType.workout
                              ? Color(0xFFC91717)
                              : Color(0xFF0C0C0C),
                          textColor: Color(0xFFD9D9D9),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          ref.read(fetchStateProvider.notifier).state =
                              FetchType.plan;
                        },
                        child: BigHashTagPill(
                          text: "PLANS",
                          textColor: Color(0xFFD9D9D9),
                          color: fetchType == FetchType.plan
                              ? Color(0xFFC91717)
                              : Color(0xFF0C0C0C),
                        ),
                      ),
                      /* SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          ref.read(fetchStateProvider.notifier).state =
                              FetchType.challenge;
                        },
                        child: BigHashTagPill(
                          text: "CHALLENGES",
                          textColor: Color(0xFFD9D9D9),
                          color: fetchType == FetchType.challenge
                              ? Color(0xFFC91717)
                              : Color(0xFF0C0C0C),
                        ),
                      ), */
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          if (query.isNotEmpty)
            discoverControllerProvider.when(
              data: (data) {
                if (data.workouts.isEmpty && data.plans.isEmpty) {
                  return Center(
                    child: Text("No results found"),
                  );
                } else if (data.workouts.isNotEmpty) {
                  return Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: data.workouts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(left: 0.0),
                              child: TextButton(
                                onPressed: () {
                                  ref
                                      .read(selectedWorkoutIdProvider.notifier)
                                      .state = data.workouts[index].id;
                                  AppRouter.goToWorkoutDetail();
                                },
                                child: WorkoutCardHorizontal(
                                  workout: data.workouts[index],
                                ),
                              ));
                        },
                      ),
                    ),
                  );
                } else if (data.plans.isNotEmpty) {
                  return Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: data.plans.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: TextButton(
                              onPressed: () {
                                ref
                                    .read(selectedPlanIdProvider.notifier)
                                    .state = data.plans[index].id;
                                AppRouter.goToPlanDetail();
                              },
                              child: PlanListCard(
                                planListItem: data.plans[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text("No results found"),
                  );
                }
              },
              loading: () => CircularProgressIndicator(),
              error: (error, stackTrace) => Text(error.toString()),
            ),
          if (query.isEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 16.0,
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  children: [
                    for (var pill in _hashTagPillsName)
                      IntrinsicWidth(
                        child: BigHashTagPill(
                            text: pill["name"].toString(),
                            color: pill["active"] == true
                                ? Color(0xFFC91717)
                                : Color(0xFF212326),
                            textColor: Color(0xFFD9D9D9),
                            onTap: (p0) {
                              if (_searchController.text.isEmpty) {
                                _searchController.text = p0;
                                pill["active"] = true;
                                setState(() {});
                              } else {
                                if (pill["active"] == false) {
                                  _searchController.text =
                                      _searchController.text + "," + p0;
                                  pill["active"] = true;
                                  setState(() {});
                                } else {
                                  _searchController.text = _searchController
                                      .text
                                      .replaceAll("," + p0, "");
                                  _searchController.text =
                                      _searchController.text.replaceAll(p0, "");
                                  pill["active"] = false;
                                  setState(() {});
                                }
                              }
                            }),
                      ),
                  ],
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                shape: ShapeBorder.lerp(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    0.5),
                  backgroundColor: Colors.black.withOpacity(0.5),
                  onPressed: () => ref.read(queryProvider.notifier).state =
                      _searchController.text,
                  child: Icon(Icons.search)),
            ),
          )
        ],
      ),
    ));
  }
}
