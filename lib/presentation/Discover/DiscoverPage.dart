import 'package:exopek_workout_app/components/DiscoverCard.dart';
import 'package:exopek_workout_app/components/PreFilterSelection.dart';
import 'package:exopek_workout_app/components/SearchbarButton.dart';
import 'package:exopek_workout_app/presentation/Discover/DiscoverFilterPageController.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dependencyInjection/discoveryProvider/discoveryFilterPageProvider.dart';

class DiscoverPage extends ConsumerStatefulWidget {
  const DiscoverPage({super.key});

  @override
  ConsumerState<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends ConsumerState<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 59,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(color: Color(0xFF212326)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 105,
                          height: 21,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 105,
                                  height: 21,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFD9D9D9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 27,
                                top: 3,
                                child: Text(
                                  'Discover',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 32,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: SearchBarButton(
                                  enabled: false,
                                  onTap: AppRouter.goToDiscoverFilter,
                                  xsize: MediaQuery.of(context).size.width - 32,
                                  hint: "Search for workouts, plans, and more",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      DiscoverCard(
                          path: 'assets/images/pexels-li-sun-2294361.jpg',
                          name: "Workouts",
                          preFilterSelections: [
                            PreFilterSelection(
                                name: "All",
                                onTap: () {
                                  ref.read(fetchStateProvider.notifier).state =
                                      FetchType.workout;
                                  ref.read(queryProvider.notifier).state =
                                      "All";
                                  AppRouter.goToDiscoverFilter();
                                }),
                            PreFilterSelection(
                              name: "Popular",
                              onTap: () {
                                ref.read(fetchStateProvider.notifier).state =
                                    FetchType.workout;
                                ref.read(queryProvider.notifier).state = "All";
                                AppRouter.goToDiscoverFilter();
                              },
                            ),
                            PreFilterSelection(
                              name: "Newest",
                              onTap: () {
                                ref.read(fetchStateProvider.notifier).state =
                                    FetchType.workout;
                                ref.read(queryProvider.notifier).state = "All";
                                AppRouter.goToDiscoverFilter();
                              },
                            ),
                            PreFilterSelection(
                              name: "Trending",
                              onTap: () {
                                ref.read(fetchStateProvider.notifier).state =
                                    FetchType.workout;
                                ref.read(queryProvider.notifier).state = "All";
                                AppRouter.goToDiscoverFilter();
                              },
                            ),
                          ]),
                      SizedBox(height: 12),
                      DiscoverCard(
                          path: 'assets/images/pexels-li-sun-2294361.jpg',
                          name: "Plans",
                          preFilterSelections: [
                            PreFilterSelection(
                                name: "All",
                                onTap: () {
                                  ref.read(fetchStateProvider.notifier).state =
                                      FetchType.plan;
                                  ref.read(queryProvider.notifier).state =
                                      "All";
                                  AppRouter.goToDiscoverFilter();
                                }),
                            PreFilterSelection(
                              name: "Popular",
                              onTap: () {
                                ref.read(fetchStateProvider.notifier).state =
                                    FetchType.plan;
                                ref.read(queryProvider.notifier).state = "All";
                                AppRouter.goToDiscoverFilter();
                              },
                            ),
                            PreFilterSelection(
                              name: "Newest",
                              onTap: () {
                                ref.read(fetchStateProvider.notifier).state =
                                    FetchType.plan;
                                ref.read(queryProvider.notifier).state = "All";
                                AppRouter.goToDiscoverFilter();
                              },
                            ),
                            PreFilterSelection(
                              name: "Trending",
                              onTap: () {
                                ref.read(fetchStateProvider.notifier).state =
                                    FetchType.plan;
                                ref.read(queryProvider.notifier).state = "All";
                                AppRouter.goToDiscoverFilter();
                              },
                            ),
                          ]),
                      SizedBox(height: 12),
                      DiscoverCard(
                          path: 'assets/images/pexels-li-sun-2294361.jpg',
                          name: "Challanges",
                          preFilterSelections: [
                            PreFilterSelection(
                                name: "All",
                                onTap: AppRouter.goToDiscoverFilter),
                            PreFilterSelection(
                              name: "Popular",
                              onTap: AppRouter.goToDiscoverFilter,
                            ),
                            PreFilterSelection(
                              name: "Newest",
                              onTap: AppRouter.goToDiscoverFilter,
                            ),
                            PreFilterSelection(
                              name: "Most Intense",
                              onTap: AppRouter.goToDiscoverFilter,
                            ),
                          ]),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
