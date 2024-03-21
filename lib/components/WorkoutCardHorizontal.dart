import 'package:exopek_workout_app/components/CardInformationBlock.dart';
import 'package:exopek_workout_app/data/AppStateProvider.dart';
import 'package:exopek_workout_app/domain/Models/Workout.dart';
import 'package:exopek_workout_app/presentation/Comments/CommentsPage.dart';
import 'package:exopek_workout_app/utils/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutCardHorizontal extends ConsumerStatefulWidget {
  final WorkoutListItem workout;
  final bool hasTrained;

  const WorkoutCardHorizontal(
      {super.key, required this.workout, this.hasTrained = false});

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
              color: widget.hasTrained ? Color(0xFFD31919) : Color(0xFF262424)),
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
                CardInformationBlock(value: widget.workout.duration.toString(), icon: Icons.watch),
                const SizedBox(width: 10),
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
                const SizedBox(width: 10),
                CardInformationBlock(value: widget.workout.likes.toString(), icon: Icons.favorite_border_rounded),
                const SizedBox(width: 10),
                if (widget.workout.comments != null && widget.workout.comments! > 0)
                  GestureDetector(
                    onTap: () {
                      ref.read(selectedWorkoutIdProvider.notifier).state =
                          widget.workout.id;
                      AppRouter.goToComments();
                    },
                    child: CardInformationBlock(value: widget.workout.comments.toString(), icon: Icons.chat_outlined),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
