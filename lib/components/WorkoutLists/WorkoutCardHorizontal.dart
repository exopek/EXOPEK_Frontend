import 'package:exopek_workout_app/components/CardInformationBlock.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/data/DioProvider.dart';
import 'package:exopek_workout_app/domain/Models/Like.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/presentation/Comments/CommentsPage.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class WorkoutCardHorizontal extends ConsumerStatefulWidget {
  final WorkoutListItem workout;
  final bool hasTrained;
  final String? lastTrained;

  const WorkoutCardHorizontal(
      {super.key, required this.workout, this.hasTrained = false, this.lastTrained});

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
          side: BorderSide(
              color: Color(0xFF262424)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Align(
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
                    ? Icon(Icons.check, color: Colors.white, size: 30)
                    : null,
              ),
            ),
          ),
          Positioned(
            left: 122,
            top: 38,
            child: Text(
              widget.workout.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 108.10,
            top: 0,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(1.57),
              child: Container(
                width: 105,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFFD31919),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 122,
            top: 20,
            child: SizedBox(
              child: Text(
                widget.workout.hashtagsStringWithHash as String,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: const TextStyle(
                  color: Color(0xFF838282),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          // Information Block
          Positioned(
            left: 122,
            top: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardInformationBlock(
                    value: widget.workout.duration.toString() + ' min',
                    icon: Icons.watch),
                const SizedBox(width: 10),
                if (widget.workout.rating != null && widget.workout.ratingAsDouble != 0.0)
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
                if (widget.workout.rating != null && widget.workout.ratingAsDouble != 0.0)   
                  const SizedBox(width: 10),
                if (widget.workout.rating != null && widget.workout.ratingAsDouble != 0.0)
                  CardInformationBlock(
                      value: widget.workout.ratingAsString.toString(),
                      icon: Icons.star_border),
                if (widget.lastTrained != null)
                  Text(
                    'Letztes Training: ${widget.lastTrained}',
                    style: const TextStyle(
                      color: Color(0xFF838282),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                    )),
                /* const SizedBox(width: 10),
                if (widget.workout.comments != null &&
                    widget.workout.comments! > 0)
                  GestureDetector(
                    onTap: () {
                      ref.read(selectedWorkoutIdProvider.notifier).state =
                          widget.workout.id;
                      AppRouter.goToComments();
                    },
                    child: CardInformationBlock(
                        value: widget.workout.comments.toString(),
                        icon: Icons.chat_outlined),
                  ) */
              ],
            ),
          ),
          Positioned(
              top: 0,
              right: 15,
              child: _svgBt('SaveNew', () {
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
                      : const Color(0xFF838282))),
        ],
      ),
    );
  }

  static Widget _svgBt(String assetBasename, VoidCallback onTap,
          {Color color = const Color(0xFF838282),
          double width = 20,
          double height = 20}) =>
      GestureDetector(
        //padding: EdgeInsets.zero,
        onTap: onTap,
        //iconSize: width > height ? width : height,
        //constraints: BoxConstraints.tightFor(width: width, height: height),
        child: SvgPicture.asset(
          'assets/svg/$assetBasename.svg',
          color: color,
          width: width,
          height: height,
        ),
      );
}
