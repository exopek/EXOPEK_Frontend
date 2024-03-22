// ignore_for_file: file_names
import 'package:exopek_workout_app/components/PromoHeader.dart';
import 'package:exopek_workout_app/components/SearchBarCustom.dart';
import 'package:exopek_workout_app/components/WorkoutLists/WorkoutCardHorizontal.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Workouts extends ConsumerStatefulWidget {
  const Workouts({super.key});

  @override
  ConsumerState<Workouts> createState() => _WorkoutsState();
}

class _WorkoutsState extends ConsumerState<Workouts> {
  TextEditingController? _searchController;
  FocusNode? _searchFocusNode;
  ScrollController? _scrollController;
  late double _promoHeaderHeight;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _scrollController = ScrollController();
    _promoHeaderHeight = 329;
    _scrollController!.addListener(_scrollListener);
  }

  /* void _scrollListener() {
    if (_scrollController!.position.pixels ==
        _scrollController!.position.maxScrollExtent) {
      ref.read(workoutProvider.notifier).fetchMore();
    }
  } */

  // change promoheader by scrolling
  void _scrollListener() {
    if (_scrollController!.position.pixels > 0) {
      setState(() {
        _promoHeaderHeight = 0;
      });
    } else {
      setState(() {
        _promoHeaderHeight = 329;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(workoutProvider);
    return result.when(
        data: (result) {
          return Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(128.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 128,
                    decoration: const BoxDecoration(color: Color(0xFF262424)),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 16,
                          top: 77,
                          child: SearchBarCustom(
                            controller: _searchController,
                            xsize: 0.8,
                            hint: 'Search',
                            focusNode: _searchFocusNode,
                          ),
                        ),
                        Positioned(
                          left: 16,
                          top: 43,
                          child: SizedBox(
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
                                      color: const Color(0xFFD9D9D9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  left: 25,
                                  top: 3,
                                  child: Text(
                                    'Workouts',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 128,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(color: Color(0xFF0C0C0C)),
                  child: CustomScrollView(
                    slivers: [
                       SliverAppBar(
                        expandedHeight: 329,
                        floating: true,
                         flexibleSpace: PromoHeader(
                            workout: result[0],
                          ),
                       ),
                      
                      /* SliverPadding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 24.0, bottom: 8.0),
                        sliver: Text(
                          '${result.length} Workouts',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Color(0xFF838282),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ), */
                      
                      SliverList(
                              delegate: SliverChildBuilderDelegate((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      ref
                                          .read(selectedWorkoutIdProvider
                                              .notifier)
                                          .state = result[index].id;
                                      AppRouter.goToWorkoutDetail();
                                    },
                                    child: WorkoutCardHorizontal(
                                      workout: result[index],
                                    ),
                                  ),
                                );
                              },
                              childCount: result.length, ),
                        ),
                      
                      ]
                  ),
                ),
              );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(e.toString())));
  }
}
