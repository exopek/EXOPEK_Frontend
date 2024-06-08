import 'package:exopek_workout_app/components/CardInformationBlock.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

class WorkoutCardHorizontal extends ConsumerStatefulWidget {
  final WorkoutListItem workout;
  final bool hasTrained;
  final String? lastTrained;
  final bool hasLikeOption;

  const WorkoutCardHorizontal(
      {super.key,
      required this.workout,
      this.hasTrained = false,
      this.lastTrained,
      this.hasLikeOption = true});

  @override
  ConsumerState<WorkoutCardHorizontal> createState() =>
      _WorkoutCardHorizontalState();
}

class _WorkoutCardHorizontalState extends ConsumerState<WorkoutCardHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 105,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFF262424)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 108.10,
              height: 105,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.workout.previewImageUrl),
                  fit: BoxFit.cover,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
              ),
              child: widget.hasTrained
                  ? const Icon(Icons.check, color: Colors.white, size: 30)
                  : null,
            ),
          ),
          Container(
            height: 105,
            width: 2,
            color: ThemeBase.of(context).secondary,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.36,
                  child: Text(
                    widget.workout.hashtagsStringWithHash as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: ThemeBase.of(context).bodySmall.copyWith(
                        color: ThemeBase.of(context).secondaryText,
                        fontSize: 10,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 
                      MediaQuery.of(context).size.width * 0.36,
                      child: Text(
                        widget.workout.name,
                        overflow: TextOverflow.ellipsis,
                        style: ThemeBase.of(context).titleMedium,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Information Block
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CardInformationBlock(
                            value: widget.workout.duration.toString() + ' min',
                            icon: _svgBt('Uhr',
                            height: 12.0,
                            width: 12.0,
                            color: ThemeBase.of(context).primaryText)),
                        const SizedBox(width: 10),
                        if (widget.workout.rating != null &&
                            widget.workout.ratingAsDouble != 0.0)
                          Container(
                            height: 12.05,
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0xFF838282),
                                ),
                              ),
                            ),
                          ),
                        if (widget.workout.rating != null &&
                            widget.workout.ratingAsDouble != 0.0)
                          const SizedBox(width: 10),
                        if (widget.workout.rating != null &&
                            widget.workout.ratingAsDouble != 0.0)
                          CardInformationBlock(
                              value: widget.workout.ratingAsString.toString(),
                              icon: Icon(
                                Icons.star,
                                color: ThemeBase.of(context).primaryText,
                                size: 12,
                              )),
                              
                        if (widget.lastTrained != null)
                          Text('Letztes Training: ${widget.lastTrained}',
                              style: const TextStyle(
                                color: Color(0xFF838282),
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w300,
                              )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.hasLikeOption)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: _svgBt('SaveNew', onTap: () {
                      if (ref
                          .watch(likedWorkoutIdsProvider)
                          .any((element) => element.workoutId == widget.workout.id)) {
                        final workoutLikeId = ref
                            .watch(likedWorkoutIdsProvider)
                            .firstWhere(
                                (element) => element.workoutId == widget.workout.id)
                            .id;
                        if (workoutLikeId != null) {
                          ref
                              .read(asyncWorkoutLikeButtonControllerProvider.notifier)
                              .deleteWorkoutLike(workoutLikeId: workoutLikeId);
                        }
                        ref.read(likedWorkoutIdsProvider.notifier).state.removeWhere(
                            (element) => element.workoutId == widget.workout.id);
                        setState(() {});
                      } else {
                        ref
                            .read(asyncWorkoutLikeButtonControllerProvider.notifier)
                            .likeWorkout(workoutId: widget.workout.id)
                            .then((value) {
                          ref.read(likedWorkoutIdsProvider.notifier).state.add(value);
                          setState(() {});
                        });
                      }
                    },
                        color: ref.watch(likedWorkoutIdsProvider).any(
                                (element) => element.workoutId == widget.workout.id)
                            ? Colors.white
                            : const Color(0xFF838282)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  static Widget _svgBt(String assetBasename,
          {Color color = const Color(0xFF838282),
          double width = 26,
          double height = 26,
          VoidCallback? onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: SvgPicture.asset(
            'assets/svg/$assetBasename.svg',
            color: color,
            width: width,
            height: height,
          ),
        ),
      );
}
