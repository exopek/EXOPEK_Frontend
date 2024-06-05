import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';

import '../../utils/AppRouter.dart';

class FadeInTransitionScreen extends StatefulWidget {
  FadeInTransitionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FadeInTransitionScreen> createState() => _FadeInTransitionScreenState();
}

class _FadeInTransitionScreenState extends State<FadeInTransitionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        AppRouter.goToPlanPhase();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeBase.of(context).primaryBackground,
      body: buildUi(),
    );
  }

  Widget buildUi() {
    return Column(
      children: [
        Expanded(child: buildChatUi()),
      ],
    );
  }

  Widget buildChatUi() {
    return Center(
      child: FadeTransition(
          opacity: _animation as Animation<double>,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 112.28,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/app_launcher_icon.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text('Plan wird geladen...',
                  style: ThemeBase.of(context).headlineMedium.copyWith(
                        color: ThemeBase.of(context).primaryText,
                      )),
            ],
          )),
    );
  }
}
