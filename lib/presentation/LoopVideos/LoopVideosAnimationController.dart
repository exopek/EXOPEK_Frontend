import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoopVideosAnimationController extends StateNotifier<AnimationController> {
  LoopVideosAnimationController(this.abortValue, this.vsync)
      : super(AnimationController(
            vsync: vsync, duration: Duration(seconds: abortValue)));

  final int abortValue;
  final TickerProvider vsync;

  void start() {
    state.forward(from: 0.0);
  }

  /* void reset() {
    Future(() {
      state =
          0; // Ändere den Zustand im nächsten Mikrotask, nachdem der Widget-Baum aufgebaut wurde
    });
  } */
}
