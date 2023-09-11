import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerAnimationLController extends StateNotifier<int> {
  TimerAnimationLController() : super(0);

  Timer? _timer;

  void increment(int abortValue) {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state == abortValue) {
        return;
      }
      state++;
      //state = AsyncData(state.value! + 1);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    //state = const AsyncData(0);
    super.dispose();
  }

  void reset() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    // Verzögert die Änderung des Zustands, bis der Widget-Baum aufgebaut wurde
    // Indem du die Änderung des Zustands in einem Future verpackst, sorgst du dafür, dass die Änderung erst nach dem aktuellen Build-Zyklus erfolgt,
    Future(() {
      state =
          0; // Ändere den Zustand im nächsten Mikrotask, nachdem der Widget-Baum aufgebaut wurde
    }); // Setze den Zustand auf 0, nachdem der Timer gestoppt wurde.
  }

  void pause() {
    _timer?.cancel();
  }
}
