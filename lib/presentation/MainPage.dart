import 'package:exopek_workout_app/presentation/Coach/Coach.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C0C0C),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Stack(
          children: [Coach()],
        ),
      ),
    );
  }
}
