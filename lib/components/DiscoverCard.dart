import 'package:exopek_workout_app/components/PreFilterSelection.dart';
import 'package:flutter/material.dart';

class DiscoverCard extends StatefulWidget {
  final String path;
  final String name;
  final List<PreFilterSelection> preFilterSelections;
  const DiscoverCard(
      {super.key,
      required this.path,
      required this.name,
      required this.preFilterSelections});

  @override
  State<DiscoverCard> createState() => _DiscoverCardState();
}

class _DiscoverCardState extends State<DiscoverCard> {
  final ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: Key(widget.name),
      trailing: null,
      controller: controller,
      title: Container(
        width: MediaQuery.of(context).size.width,
        height: 170,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 170,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 36,
              top: 42,
              child: SizedBox(
                width: 214,
                height: 41,
                child: Text(
                  widget.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      children: [
        for (var preFilterSelection in widget.preFilterSelections)
          preFilterSelection,
      ],
    );
  }
}
