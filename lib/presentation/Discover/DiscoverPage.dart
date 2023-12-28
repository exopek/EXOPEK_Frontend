import 'package:exopek_workout_app/components/DiscoverCard.dart';
import 'package:exopek_workout_app/components/SearchbarButton.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF0C0C0C)),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 128,
                decoration: BoxDecoration(color: Color(0xFF212326)),
              ),
            ),
            Positioned(
              left: 16,
              top: 77,
              child: Container(
                width: 355,
                height: 32,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: SearchBarButton(
                        onTap: AppRouter.goToDiscoverFilter,
                        xsize: 355,
                        hint: "Search for workouts, plans, and more",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 764,
              child: Container(
                width: 390,
                height: 80,
                decoration: BoxDecoration(color: Color(0xFF262323)),
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
            Positioned(
              top: 162,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height - 280,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      DiscoverCard(
                          path: 'assets/images/pexels-li-sun-2294361.jpg',
                          name: "Workouts"),
                      SizedBox(height: 12),
                      DiscoverCard(
                          path: 'assets/images/pexels-li-sun-2294361.jpg',
                          name: "Plans"),
                      SizedBox(height: 12),
                      DiscoverCard(
                          path: 'assets/images/pexels-li-sun-2294361.jpg',
                          name: "Plans"),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
