import 'package:exopek_workout_app/components/Profil/CustomTimelineEventCard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String date;
  final String workoutName;
  const CustomTimelineTile({super.key, required this.isFirst, required this.isLast, required this.isPast, required this.date, required this.workoutName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: TimelineTile(
        
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast ? Color(0xFFD12626) : Color(0xFF262424),
          thickness: 2,
        ),
        indicatorStyle: IndicatorStyle(
          width: 40,
          height: 40,
          indicator: Container(
            child: Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              
            )),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPast ? Color(0xFFD12626) : Color(0xFF262424),
            ),
          ),
        ),
        endChild: CustomTimelineEventCard(
          eventName: workoutName,
          eventDate: date,
        )
      ),
    );
  }
}