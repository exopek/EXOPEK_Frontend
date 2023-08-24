import 'package:exopek_workout_app/components/PromoHeader.dart';
import 'package:exopek_workout_app/components/SearchBarCustom.dart';
import 'package:exopek_workout_app/components/WorkoutCardHorizontal.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
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

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(workoutProvider);
    return result.when(
        data: (result) {
          return SafeArea(
            child: Scaffold(
                appBar: PreferredSize(
                    child: Container(
                      width: 390,
                      height: 128,
                      decoration: BoxDecoration(color: Color(0xFF262424)),
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
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
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
                    ),
                    preferredSize: Size.fromHeight(128.0)),
                body: SingleChildScrollView(
                  child: Container(
                    width: 390,
                    height: 844,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
                    child: Column(
                      children: [
                        /* Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 390,
                            height: 128,
                            decoration: BoxDecoration(color: Color(0xFF262424)),
                          ),
                        ),
                        Positioned(
                            left: 16,
                            top: 77,
                            child: SearchBarCustom(
                              controller: _searchController,
                              xsize: 0.8,
                              hint: 'Search',
                              focusNode: _searchFocusNode,
                            )),
                        Positioned(
                          left: 16,
                          top: 43,
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
                    ), */

                        PromoHeader(
                          workout: result[0],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 24.0, bottom: 8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '136 Workouts',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF838282),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 32.0),
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: result.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: WorkoutCardHorizontal(
                                      workout: result[index],
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(e.toString())));
  }
}
