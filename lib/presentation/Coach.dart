import 'dart:async';

import 'package:exopek_workout_app/components/AreaSelection.dart';
import 'package:exopek_workout_app/components/CurvedHeader.dart';
import 'package:exopek_workout_app/components/NavigationBarCustom.dart';
import 'package:exopek_workout_app/components/PlanCardHorizontal.dart';
import 'package:exopek_workout_app/components/PlanProgressCard.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class Coach extends StatefulWidget {
  const Coach({super.key});

  @override
  State<Coach> createState() => _CoachState();
}

class _CoachState extends State<Coach> {
  late ScrollController _scrollController;
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
    /* loadImage('assets/images/testImage.jpeg').then((value) => image = value); */
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF0C0C0C),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    child: SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: CustomPaint(
                        painter:
                            CurveHeader(color: Colors.blueGrey, image: null),
                        /* child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage('assets/images/testImage.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ), */
                      ),
                    )),
                Positioned(left: 16, top: 369, child: PlanProgressCard()),
                Positioned(
                  left: 16,
                  top: 329,
                  child: Text(
                    'Dein aktueller Plan',
                    style: TextStyle(
                      color: Color(0xFF838282),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                /* Positioned(
                  left: 16,
                  top: 606,
                  child: Text(
                    'Build your Training Habits',
                    style: TextStyle(
                      color: Color(0xFF838282),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ), */
                Positioned(
                  left: 86,
                  top: 108,
                  child: Text(
                    'EXOPEK Athlet Stufe 1',
                    style: TextStyle(
                      color: Color(0xFF838282),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 157,
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
                Positioned(
                  left: 16,
                  top: 71,
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/testImage.jpeg') /* NetworkImage("https://via.placeholder.com/65x65") */,
                        fit: BoxFit.cover,
                      ),
                      shape: OvalBorder(
                        side: BorderSide(width: 1, color: Color(0xFF262424)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 86,
                  top: 88,
                  child: SizedBox(
                    width: 100,
                    child: Text(
                      'Jan Sugint',
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
                    top: 192,
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return TextButton(
                              onPressed: () {
                                if (index == 0) AppRouter.goToWorkouts();
                                if (index == 1) AppRouter.goToPlans();
                              },
                              child: AreaSelection(
                                  label: "Workouts",
                                  assetPath:
                                      "assets/images/yoga-pose_8105706.png"),
                            );
                          }),
                    )),
                Positioned(
                  left: 321,
                  top: 17,
                  child: Container(
                    width: 60,
                    height: 33.68,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage("assets/images/app_launcher_icon.png"),
                        invertColors: false,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
