import 'package:flutter/material.dart';

class PlanAction extends StatefulWidget {
  const PlanAction({super.key});

  @override
  State<PlanAction> createState() => _PlanActionState();
}

class _PlanActionState extends State<PlanAction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 199, 12, 121),
        child: Text('PlanAction'),
      ),
    );
  }
}
