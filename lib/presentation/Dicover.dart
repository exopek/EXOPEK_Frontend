import 'package:exopek_workout_app/components/WorkoutCard.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/SearchBarCustom.dart';

class Discover extends ConsumerStatefulWidget {
  const Discover({super.key});

  @override
  ConsumerState<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends ConsumerState<Discover> {
  TextEditingController? _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(combinedWorkoutProvider);

    return result.when(
        data: (result) {
          return Container(
            width: 390,
            height: 844,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
            child: Stack(
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
                  top: 43,
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
                  left: 16,
                  top: 77,
                  child: SearchBarCustom(
                      controller: _searchController, xsize: 0.8),
                ),
                Positioned(
                  left: 16,
                  top: 150,
                  child: SizedBox(
                    width: 124,
                    height: 27,
                    child: Text(
                      'Trending',
                      style: TextStyle(
                        color: Color(0xFF838282),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 19,
                  top: 390,
                  child: SizedBox(
                    width: 124,
                    height: 27,
                    child: Text(
                      'Quick - Burner',
                      style: TextStyle(
                        color: Color(0xFF838282),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 19,
                  top: 184,
                  child: Container(
                    width: 291.08,
                    height: 199,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 291.08,
                            height: 199,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/291x199"),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 17.12,
                          top: 139.52,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Functional Basic\n',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '29 - 43 MIN. - GANZER KÖRPER - 125 PUNKTE',
                                  style: TextStyle(
                                    color: Color(0xFF838282),
                                    fontSize: 10,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 265.96,
                          top: 12.44,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: ShapeDecoration(
                              color: Color(0xFF0E68EE),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    left: 0,
                    top: 422,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 300,
                      child: ListView.builder(
                          controller:
                              ScrollController(initialScrollOffset: -15.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: result['workouts']!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: WorkoutCard(
                                  workout: result['workouts']![index]),
                            );
                          }),
                    )),
                Positioned(
                  left: 0,
                  top: 764,
                  child: Container(
                    width: 390,
                    height: 80,
                    decoration: BoxDecoration(color: Color(0xFF262323)),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(e.toString())));
  }
}
