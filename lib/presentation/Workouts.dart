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
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Color(0xFF212326),
              title: Text('Workouts'),
              ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Color(0xFF0C0C0C)),
              child: CustomScrollView(slivers: [
                SliverAppBar(
                  leading: Container(),
                  expandedHeight: 329,
                  floating: true,
                  flexibleSpace: PromoHeader(
                    workout: result.firstWhere(
                        (element) => element.isWorkoutOfTheWeek == true),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextButton(
                          onPressed: () {
                            ref.read(selectedWorkoutIdProvider.notifier).state =
                                result[index].id;
                            AppRouter.goToWorkoutDetail();
                          },
                          child: WorkoutCardHorizontal(
                            workout: result[index],
                          ),
                        ),
                      );
                    },
                    childCount: result.length,
                  ),
                ),
              ]),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(e.toString())));
  }
}
