import 'package:exopek_workout_app/components/AreaSelection.dart';
import 'package:exopek_workout_app/components/NavigationBarCustom.dart';
import 'package:exopek_workout_app/components/PlanCardHorizontal.dart';
import 'package:exopek_workout_app/components/PlanProgressCard.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';

class Coach extends StatefulWidget {
  const Coach({super.key});

  @override
  State<Coach> createState() => _CoachState();
}

class _CoachState extends State<Coach> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C0C0C),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 844,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
          child: Stack(
            children: [
              // Selection
              Positioned(
                  top: 620,
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        padding: EdgeInsets.only(
                          left: 22,
                        ),
                        physics: BouncingScrollPhysics(),
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return TextButton(
                            onPressed: () {
                              AppRouter.goToWorkouts();
                            },
                            child: AreaSelection(
                                label: "Workouts",
                                assetPath: "assets/images/IMG_1407.PNG"),
                          );
                        }),
                  )),
              // Plan
              Positioned(left: 32, top: 345, child: PlanCardHorizontal()),
              // Progress
              Positioned(
                  left: 32, top: 184, right: 32, child: PlanProgressCard()),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 390,
                  height: 128,
                  decoration: BoxDecoration(
                    color: Color(0x00D9D9D9),
                    border: Border(
                      bottom: BorderSide(width: 0.25, color: Color(0xFFD31919)),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 125,
                top: 25,
                child: Container(
                  width: 140,
                  height: 78.60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/app_launcher_icon.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 154,
                child: Text(
                  'Dein aktueller Plan',
                  style: TextStyle(
                    color: Color(0xFF838282),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 589,
                child: Text(
                  'Alles zu EXOPEK',
                  style: TextStyle(
                    color: Color(0xFF838282),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
