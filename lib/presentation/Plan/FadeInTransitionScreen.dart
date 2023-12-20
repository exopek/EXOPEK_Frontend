import 'package:exopek_workout_app/domain/Models/Plan.dart';
import 'package:flutter/material.dart';

import '../../utils/AppRouter.dart';

class FadeInTransitionScreen extends StatefulWidget {
  final PlanPhase planPhase;

  FadeInTransitionScreen({
    Key? key,
    required this.planPhase,
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
        AppRouter.goToPlanPhase(widget.planPhase);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 180, 15, 145),
      body: buildUi(),
    );
  }

  Widget buildUi() {
    return Column(
      children: [
        Expanded(child: buildChatUi()),
        // buildBottomView()
      ],
    );
  }

  Widget buildChatUi() {
    return Container(
      child: Center(
        child: FadeTransition(
            opacity: _animation as Animation<double>,
            child: Center(
                child: Text(
              'Plan Started',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ))),
      ),
    );
  }
}
