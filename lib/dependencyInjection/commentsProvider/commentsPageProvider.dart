import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/domain/Models/Comment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentsProvider =
    FutureProvider.autoDispose<List<Comment>>((ref) async {
      final id = ref.read(selectedWorkoutIdProvider);
  final data = await ref.watch(dioWorkoutProvider).getWorkoutComments(id);
  return data;
});