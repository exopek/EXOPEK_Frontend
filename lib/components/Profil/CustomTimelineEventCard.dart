import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class CustomTimelineEventCard extends StatelessWidget {
  final String eventName;
  final String eventDate;
  const CustomTimelineEventCard({super.key, required this.eventName, required this.eventDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0x00D9D9D9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1, color: Color(0xFF262424),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(eventName),
          Text(eventDate),
        ],
      ),
    );
  }
}