import 'package:exopek_workout_app/components/PlanListCard.dart';
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
            appBar: PreferredSize(
                child: Container(
                  width: 390,
                  height: 168,
                  decoration: BoxDecoration(color: Color(0xFF262424)),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 16,
                        top: 117,
                        child: SearchBarCustom(
                          controller: _searchController,
                          xsize: 0.8,
                          hint: 'Search',
                          focusNode: _searchFocusNode,
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 83,
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
                                  child: Center(
                                    child: Text(
                                      'Plans',
                                      textAlign: TextAlign.center,
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                preferredSize: Size.fromHeight(128.0)),
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                width: 390,
                height: MediaQuery.sizeOf(context).height - 158,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
                child: Column(
                  children: [
                    Padding(
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
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: ListView.builder(
                            itemCount: result.plans.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
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
            ));
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
    );
  }
}
