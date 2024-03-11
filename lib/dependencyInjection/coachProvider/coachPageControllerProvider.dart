import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/Models/ViewModels/CoachPageViewModel.dart';
import '../../presentation/Coach/CoachPageController.dart';

final asyncCoachPageController =
    AsyncNotifierProvider.autoDispose<CoachPageController, CoachPageViewModel>(
        () {
  return CoachPageController();
});
