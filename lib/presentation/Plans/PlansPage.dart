import 'package:exopek_workout_app/components/PlanListCard.dart';
import 'package:exopek_workout_app/components/VideoPlayers/VisibleListVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/SearchBarCustom.dart';
import '../../dependencyInjection/plansProvider/PlansProvider.dart';
import '../../utils/AppRouter.dart';

class PlansPage extends ConsumerStatefulWidget {
  const PlansPage({super.key});

  @override
  ConsumerState<PlansPage> createState() => _PlansPageState();
}

class _PlansPageState extends ConsumerState<PlansPage> {
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
    final result = ref.watch(asyncPlansPageControllerProvider);
    return result.when(
      data: (result) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF212326),
              title: Text('Pläne'),
              ),/* PreferredSize(
                preferredSize: const Size.fromHeight(150.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: const BoxDecoration(color: Color(0xFF212326)),
                  child: Column(
                    children: [
                      SizedBox(height: 70),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 105,
                            height: 21,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFD9D9D9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Plans',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: SearchBarCustom(
                          controller: _searchController,
                          xsize: 1.0,
                          hint: 'Search',
                          focusNode: _searchFocusNode,
                        ),
                      ),
                    ],
                  ),
                )), */
            body: Container(
                width: MediaQuery.sizeOf(context).width,
                //height: MediaQuery.sizeOf(context).height - 158,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
                child: Column(
                  children: [
                    /* Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 24.0, bottom: 8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${result.plans.length} Pläne',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF838282),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ), */
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: ListView.builder(
                            itemCount: result.plans.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8.0,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    if (result.planStatuses.any((element) =>
                                        element.planId ==
                                        result.plans[index].id)) {
                                      print("active plan");
                                      ref
                                          .read(selectedPlanIdProvider.notifier)
                                          .state = result.plans[index].id;
                                      AppRouter.goToPlanPhaseWithLastRoute();
                                    } else {
                                      ref
                                          .read(selectedPlanIdProvider.notifier)
                                          .state = result.plans[index].id;
                                      AppRouter.goToPlanDetail();
                                    }
                                  },
                                  child: PlanListCard(
                                    planListItem: result.plans[index],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
    );
  }
}
