import 'package:exopek_workout_app/domain/Models/DiscoverFilterPageViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/Discover/DiscoverFilterPageController.dart';

final asyncDiscoverFilterPageController = AsyncNotifierProvider.autoDispose<
    DiscoverFilterPageController, DiscoverFilterPageViewModel>(() {
  return DiscoverFilterPageController();
});

final fetchStateProvider = StateProvider<FetchType>((ref) {
  return FetchType.none;
});

final queryProvider = StateProvider<String>((ref) {
  return "";
});
