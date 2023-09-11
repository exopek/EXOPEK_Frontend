import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoopVideosProgressIndicatorController extends StateNotifier<int> {
  LoopVideosProgressIndicatorController() : super(0);

  void increment() {
    state++;
  }

  void reset() {
    Future(() {
      state =
          0; // Ändere den Zustand im nächsten Mikrotask, nachdem der Widget-Baum aufgebaut wurde
    });
  }
}
